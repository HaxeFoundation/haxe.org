using StringTools;

/**
 *  Deploy the generated site to S3 using aws cli.
 *
 *  It use the following enviroment variables:
 *   - S3_BUCKET
 *   - TRAVIS_BRANCH
 *   - AWS_ACCESS_KEY_ID
 *   - AWS_SECRET_ACCESS_KEY
 *   - AWS_DEFAULT_REGION
 */
class Deploy {
    static function cmd(cmd:String, ?params:Array<String>):Void {
        Sys.println('run: $cmd $params');
        var exitCode = Sys.command(cmd, params);
        if (exitCode != 0)
            throw 'Error running $cmd $params';
    }
    static function aws(params:Array<String>):Void {
        cmd("aws", params);
    }
    static function main() {
        var S3_BUCKET = Sys.getEnv("S3_BUCKET");
        var BRANCH = Sys.getEnv("TRAVIS_BRANCH");
        var downloadsData = DownloadsData.getData();

        switch([Sys.getEnv("AWS_ACCESS_KEY_ID"), Sys.getEnv("AWS_SECRET_ACCESS_KEY")]) {
            case [null, _] | [_, null]:
                Sys.println("missing aws credentials, skip deploy");
                return;
            case _:
                //pass
        }

        // Sync all the files to S3 and delete the removed files.
        aws([
            "s3", "sync", "out", 's3://${S3_BUCKET}/${BRANCH}',
            "--delete",

            // Do not delete the download redirections.
            // Although they will be recreated below, but we don't want any download to fail in the mean time.
            "--exclude", "website-content/downloads/*", 
        ]);

        // Set up redirections of the download files to GitHub releases.
        for (version in downloadsData.versions) {
            for (download in (version.api != null ? [version.api] : []).concat(version.downloads.all)) {
                aws([
                        "s3api", "put-object",
                        "--acl", "public-read",
                        "--website-redirect-location", download.url,
                        "--bucket", S3_BUCKET,
                        "--key", '${BRANCH}/website-content/downloads/${version.version}/downloads/${download.filename}'
                ]);
            }
            if (version.version == downloadsData.current) {
                for (download in version.downloads.all) {
                    aws([
                            "s3api", "put-object",
                            "--acl", "public-read",
                            "--website-redirect-location", download.url,
                            "--bucket", S3_BUCKET,
                            "--key", '${BRANCH}/website-content/downloads/latest/downloads/${download.filename.replace(version.version, "latest")}'
                    ]);
                }
            }
        }

        // invalidate CloudFront cache
        switch(Sys.getEnv('CLOUDFRONT_DISTRIBUTION_ID_${BRANCH}')) {
            case null:
                Sys.println('missing CLOUDFRONT_DISTRIBUTION_ID_${BRANCH}, skip CloudFront cache invalidation');
            case distID:
                aws(["configure", "set", "preview.cloudfront", "true"]);
                aws([
                    "cloudfront", "create-invalidation",
                    "--distribution-id", distID,
                    "--paths", "/*"
                ]);
        }

    }
}