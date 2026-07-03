# ============================================================================
# DEVELOPMENT DEPLOYMENT
# ============================================================================
deployment "development" {
  inputs = {
    # Environment & Region
    environment = "development"
    aws_region  = "eu-west-1"
    region      = "eu-west-1"

    # Resource Naming
    name = "tfe-dev"

    # Networking & DNS
    hosted_zone_name = "mohamed-abdelbaset.sbx.hashidemos.io"
    dns_record       = "aws-tfe-fdo-stacks.mohamed-abdelbaset.sbx.hashidemos.io"

    # ACME/Let's Encrypt Configuration
    # Use staging for testing to avoid rate limits
    acme_server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"

    # Email for ACME/Let's Encrypt
    email = "admin@example.com"

    # TFE Configuration
    # IMPORTANT: override tfe_license, tfe_admin_password, tfe_encryption_password,
    # and rds_password with sensitive values via the TFE stack Variables UI
    tfe_hostname            = "aws-tfe-fdo-stacks.mohamed-abdelbaset.sbx.hashidemos.io"
    tfe_license             = "02MV4UU43BK5HGYYTOJZWFQMTMNNEWU33JJVWVS6CNNVCTGTT2IF2E4R2KNVHUGMLIJ5CGQ22MKRHG2WSXJV2FSVCWNVGUIVTIJZKFM3KZKRMTKSLJO5UVSM2WPJSEOOLULJMEUZTBK5IWST3JJE2FUVCCNVHDESTLJZUTA6CZPJCXQTCUM42E4VDDORMVOUL2JVUTC2CPKRWGST2HKF4U46SZGRGVOVLJJRBUU4DCNZHDAWKXPBZVSWCSOBRDENLGMFLVC2KPNFEXCSLJO5UWCWCOPJSFOVTGMRDWY5C2KNETMSLKJF3U22SZORGUIVLUJVCGIVKNIRTTMTKEMM3E26TDOVHGUYZQJZ5GGMCPKRGTKV3JJFZUS3SOGBMVQSRQLAZVE4DCK5KWST3JJF4U2RCJGJGFIQJRJRKECM2WIRAXOT3KIF3U62SBO5LWSSLTJFWVMNDDI5WHSWKYKJYGEMRVMZSEO3DULJJUSNSJNJEXOTLKLF2E2RDHORGXURSVJVCECNSNIRATMTKEIJQUS2LXNFSEOVTZMJLWY5KZLBJHAYRSGVTGIR3MORNFGSJWJFVES52NNJMXITKEM52E26SGKVGUIQJWJVCECNSNIRBGCSLJO5UWGSCKOZNEQVTKMRBUSNSJNZJGYY3OJJUFU3JZPFRFGSLTJFWVU42ZK5SHUSLKOA3US3K2NRMVQURRMNWVM6SJNJYGESLOJYYFSV2OOJRXSSTEMZMDAPJOJVGS6LZPJNGXG23ENBRTML2DIVAXI2KNKFRXOY2RJFRFOUCJPJATISLBJRHUSM3QIVXUCMSPGJXTGURSKNGTAZRXORJXGYRQNFZE4NLZHFBFSYTVGBXVUVSHI4YUINLENZZU4ZSDOAYWIQLLMNQTIZCWGAZTGOCQO5WVM3DBOZFFANDQJJ4ESSJZIQ3FKRSMKVQVMUDKNNLUU5DDIQ3HAYLMGZXU6ZSHNZFTE6SQJNFFE3KHJBLDGZK2O5YUMZJLN43WWL3TFNAVITTIKBNGOUZPJNLFSZZPJMVWYR2QO5GDO2SCPBETOR2PMFVTMVLBNFQUQ33FNMYFEVDPG4ZEIUJ5HU"
    tfe_admin_password      = "Mystrongpassword123"
    tfe_encryption_password = "Mystrongpassword123"
    tfe_image_tag           = "2.0.3"

    # TFE Directories
    certs_dir = "/etc/terraform-enterprise/certs"
    data_dir  = "/etc/terraform-enterprise/"

    # EC2 Instance
    instance_type = "t2.large"

    # Database Configuration
    db_user      = "postgres"
    rds_password = "Mystrongpassword123"
    rds_db_name  = "tfe"

    # S3 Storage
    s3_bucket_name = "tfe-dev-data-bucket-unique-name"
  }
}
