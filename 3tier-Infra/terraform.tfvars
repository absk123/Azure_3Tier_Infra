monolith = {
    FronEnd_Resource= {
        rg_name="monolith-resources"
        vner_name="monolith-network"
        sbnet_name= "FrontEnd_Subnet"
        pip_name="Frontend_vm_ip"
        nic_name="FE_VM_nic"
        vm_name="FE_Linux_VM"
        size="Standard_B1s"
        ip_add= ["10.0.2.0/24"]
    },
    BackEnd_Resource= {
        rg_name="monolith-resources"
        vner_name="monolith-network"
        sbnet_name= "FrontEnd_Subnet"
        pip_name="Frontend_vm_ip"
        nic_name="FE_VM_nic"
        vm_name="FE_Linux_VM"
        size="Standard_B1s"
    }
}