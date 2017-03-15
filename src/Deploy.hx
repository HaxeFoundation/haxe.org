import Main; //trigger its build macros...
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
        var downloadsData = generators.Downloads.getData();

        switch([Sys.getEnv("AWS_ACCESS_KEY_ID"), Sys.getEnv("AWS_SECRET_ACCESS_KEY")]) {
            case [null, _] | [_, null]:
                Sys.println("missing aws credentials, skip deploy");
            case _:
                //pass
        }

        // Sync all the files to S3 and delete the removed files.
        aws(["s3", "sync", "out", 's3://${S3_BUCKET}/${BRANCH}', "--delete"]);

        // Set up redirections of the download files to GitHub releases.
        for (version in downloadsData.versions) {
            for (download in
                (version.api ? [{ filename: 'api-${version.version}.zip' }] : [])
                .concat(version.downloads.osx)
                .concat(version.downloads.windows)
                .concat(version.downloads.linux)
            ){
                aws([
                        "s3api", "put-object",
                        "--acl", "public-read",
                        "--website-redirect-location", 'https://github.com/HaxeFoundation/haxe/releases/download/${version.tag}/${download.filename}',
                        "--bucket", S3_BUCKET,
                        "--key", '${BRANCH}/website-content/downloads/${version.version}/downloads/${download.filename}'
                ]);
            }
            if (version.version == downloadsData.current) {
                for (download in
                    []
                    .concat(version.downloads.osx)
                    .concat(version.downloads.windows)
                    .concat(version.downloads.linux)
                ){
                    aws([
                            "s3api", "put-object",
                            "--acl", "public-read",
                            "--website-redirect-location", 'https://github.com/HaxeFoundation/haxe/releases/download/${version.tag}/${download.filename}',
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