data "aws_acm_certificate" "san_cert" {
  domain   = "${var.domain_cert}"
  statuses = ["${var.cert_statuses}"]
}

resource "aws_cloudfront_origin_access_identity" "access_identity" {
  comment = "${var.domain_fqdn}-cloudfront-access-identity"
}

data "aws_iam_policy_document" "s3" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.domain_fqdn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.access_identity.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.domain_fqdn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.access_identity.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.domain_fqdn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${var.cicd_user_arn}"]
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.domain_fqdn}"
  acl    = "public-read"
  policy = "${data.aws_iam_policy_document.s3.json}"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  versioning {
    enabled = true
  }
}

resource "aws_cloudfront_distribution" "cf_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.bucket.bucket_domain_name}"
    origin_id   = "s3-${var.domain_fqdn}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.access_identity.cloudfront_access_identity_path}"
    }
  }

  price_class = "PriceClass_100"
  aliases = ["${var.domain_fqdn}"]
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-${var.domain_fqdn}"
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "${data.aws_acm_certificate.san_cert.arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  custom_error_response {
    error_caching_min_ttl = 5
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }
}
