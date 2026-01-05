terraform {
  backend "s3" {

    # =========================================================
    # COMMON BACKEND SETTINGS (USED IN ALL ENVIRONMENTS)
    # =========================================================

    bucket         = "aws-terraform-remote-state-bucket"   # MUST be globally unique
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"                    # State locking
    encrypt        = true                                 # Enable SSE encryption
    key = "dev/terraform.tfstate"                         #bassed on your state

    # =========================================================
    # ENVIRONMENT-SPECIFIC STATE KEYS
    # =========================================================
    # ❗ Only ONE 'key' must be ACTIVE at a time
    # ❗ Comment / uncomment based on environment
    # ❗ Run 'terraform init -reconfigure' after change
    # =========================================================


    # ---------------- DEV ENVIRONMENT ----------------
    # Use when:
    # - Local development
    # - Feature testing
    # - Non-critical changes
    #
    # key = "dev/terraform.tfstate"


    # ---------------- TEST ENVIRONMENT ----------------
    # Use when:
    # - Integration testing
    # - QA validation
    # - Pre-production checks
    #
    # key = "test/terraform.tfstate"


    # ---------------- PROD ENVIRONMENT ----------------
    # Use when:
    # - Production deployment
    # - Live workloads
    # - Strict change control
    #
    # key = "prod/terraform.tfstate"

  }
}
