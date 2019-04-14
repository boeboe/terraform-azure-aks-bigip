The following lines had to be removed from the JSON file, due to a bug/feature in az cmd tool:
https://github.com/terraform-providers/terraform-provider-azurerm/issues/1437 
 
    {
        "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#", 
        "contentVersion": "6.0.4.0", 
        "parameters": {}
    }

