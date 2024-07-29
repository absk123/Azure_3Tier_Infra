monolith = {
    sb1= {
        sbnet_name= "backendsubnet"
        address_prefixes=["10.0.2.0/24"]
        nic_name= "frontend-nic"
        vm_name= "frontend-vm"
        size= "Standard_D2_v3"
    },
    sb2= {
        sbnet_name= "frontendsubnet"
        address_prefixes=["10.0.1.0/24"]
        nic_name= "backend-nic"
        vm_name= "backend-vm"
        size= "Standard_D2_v3"
    }
}

secret_value = "adminuser@123"

secrets = "adminuser"
