<img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/345797e6/images/logo-terraform.svg" width="200" />

# infrastructure-terraform-modules
A collection of reusable Terraform modules

Looking for an orchestration of these modules? Check out our [infrastructure-terraform](https://github.com/silverback-insights/infrastructure-terraform) repo.

## Current modules

* [Data stores](./init/data-stores)
  * [Postgres](./data-stores/postgres) <img src="https://www.google.com/s2/favicons?domain=www.postgres.com" height="16" />
  * [Redis](./data-stores/redis) <img src="https://www.google.com/s2/favicons?domain=redis.io" height="16" />
* [Initialization](./init)
  * [VPC](./init/vpc) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/a63375ad/images/logo-aws-vpc.svg" height="16" />
  * [KMS Key](./init/kms-key) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/61b238c8/images/logo-aws-kms.png" height="16" />
  * [DNS](./init/dns) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/61b238c8/images/logo-aws-dns.png" height="16" />
  * [Bastion host](./init/bastion) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/fe7e3fd7/images/logo-bastion-host.png" height="16" />
  * [Users](./init/users) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/dab6c896/images/logo-users.svg" height="16" />
  * [IAM](./init/iam) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/45065784/images/logo-aws-iam.png" height="16" />
  * [S3 Bucket](./init/s3-bucket) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/52033031/images/logo-aws-s3.svg" height="16" />
* [Services](./services)
  * [GraphQL](./services/graphql) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/dab6c896/images/logo-graphql.png" height="16" />
  * [UI (static)](./services/ui-static) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/dab6c896/images/logo-aws-cloudfront.png" height="16" /> <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/dab6c896/images/logo-react.png" height="16" />
  * [UI (dynamic)](./services/ui-app) <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/dab6c896/images/logo-nodejs.svg" height="16" /> <img src="https://cdn.rawgit.com/silverback-insights/hosted-assets/dab6c896/images/logo-react.png" height="16" />

_We're always adding more..._
