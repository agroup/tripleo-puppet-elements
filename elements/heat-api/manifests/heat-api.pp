class {"heat::api":
    enabled => $enabled,
}

class {"heat::api_cfn":
    enabled => $enabled,
}

class {"heat::api_cloudwatch":
    enabled => $enabled,
}
