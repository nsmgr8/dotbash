# bash command-line completion for virtualbox
# development version, or specially used for my opts
# Author: Sebastian T. Hafner <sonix@own-hero.net>

_VBoxManage() {
    local cur prev opts vms cmd hdds
    COMPREPLY=()
    vms=`VBoxManage -q list vms | awk -F\" '{ print $2 }'`
    hdds=`VBoxManage -q list hdds | grep Location | awk -F\/ '{ print $NF }'`
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    if [[ COMP_CWORD -ge 2 ]]; then
    	cmd="${COMP_WORDS[1]}"
	if [[ $cmd == "-q" ]]; then
    		cmd="${COMP_WORDS[2]}"
	fi
    fi
    opts=`VBoxManage -q help | grep VBoxManage\ [a-z] | awk '{ print $2 }' | uniq`
    opts="$opts -q --quiet -v --version"

    if [[ ${cur} == "-q" || ${COMP_CWORD} -eq 1 ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi


    case "${prev}" in
        showhdinfo|clonehd)
            COMPREPLY=( $(compgen -W "$hdds" \
                -- ${cur}) )
            ;;
	--format)
            COMPREPLY=( $(compgen -W "VDI VMDK VHD" \
                -- ${cur}) )
            ;;
        storageattach|startvm|modifyvm|controlvm|showvminfo|unregistervm|vmstatistics)
            COMPREPLY=( $(compgen -W "$vms" \
                -- ${cur}) )
            ;;
	--type) #startvm --type
	    if [[ ${cmd} == "startvm" ]]; then
            	COMPREPLY=( $(compgen -W "headless vrdp sdl gui" \
            	    -- ${cur}) )
	    fi
	    if [[ ${cmd} == "createhd" ]]; then
            	COMPREPLY=( $(compgen -W "normal writethrough" \
            	    -- ${cur}) )
	    fi
            ;;
	--ostype)
	    OS=`VBoxManage list ostypes | grep ID | awk '{ print $2 }'`
            COMPREPLY=( $(compgen -W "$OS" \
                -- ${cur}) )
            ;;
	--variant)
            COMPREPLY=( $(compgen -W "Standard Fixed Split2G Stream ESX" \
                -- ${cur}) )
            ;;
	--vrdpauthtype) 
            COMPREPLY=( $(compgen -W "null external guest" \
                -- ${cur}) )
            ;;
	--nictype[1-6]) 
            COMPREPLY=( $(compgen -W "Am79C970A Am79C973 82540EM 82543GC 82545EM" \
                -- ${cur}) )
            ;;
	--nic[1-6]) 
            COMPREPLY=( $(compgen -W "bridged none null nat hostonly intnet" \
                -- ${cur}) )
            ;;
	--boot[1-4]) 
            COMPREPLY=( $(compgen -W "none floppy dvd disk net" \
                -- ${cur}) )
            ;;
	--sataport[1-6]) 
            COMPREPLY=( $(compgen -W "$hdds" \
                -- ${cur}) )
            ;;
	*vrdp) 
            COMPREPLY=( $(compgen -W "on off" \
                -- ${cur}) )
            ;;
	disk) 
            COMPREPLY=( $(compgen -W "$hdds" \
                -- ${cur}) )
            ;;
	list) 
            COMPREPLY=( $(compgen -W "vms runningvms ostypes hostdvds hostfloppies
	                                bridgedifs hostonlyifs dhcpservers hostinfo 
					hddbackends hdds dvds floppies
					usbhost usbfilters systemproperties" \
                -- ${cur}) )
            ;;
	# --storageattach
	--storagectl)
	    CONTROLLER="SATA IDE"
            COMPREPLY=( $(compgen -W "$CONTROLLER" \
                -- ${cur}) )
	    ;;
	--device)
            COMPREPLY=( $(compgen -W "0" \
                -- ${cur}) )
	    ;;
	--port)
            COMPREPLY=( $(compgen -W "1 2 3 4" \
                -- ${cur}) )
	    ;;
	--type)
            COMPREPLY=( $(compgen -W "dvddrive hdd fdd" \
                -- ${cur}) )
	    ;;
	--medium)
            COMPREPLY=( $(compgen -W "none $hdds" \
                -- ${cur}) )
	    ;;
	--*) #any options ..
	    COMPREPLY=()
	    ;;
        *)
		case "${cmd}" in
        		createhd)
            			COMPREPLY=( $(compgen -W "--filename --size --type 
	    					--format --comment --remember --variant" \
            				    -- ${cur}) )
            			;;
			createvm)
        			COMPREPLY=( $(compgen -W "--name --ostype --register --basefolder 
						--settingsfile --uid" \
					-- ${cur}) )
				;;
			controlvm)
        			COMPREPLY=( $(compgen -W "pause resume poweroff reset savestate 
						acpipowerbutton acpisleepbutton
						vrdp " \
					-- ${cur}) )
				;;
			startvm)
        			COMPREPLY=( $(compgen -W "--type" -- ${cur}) )
				;;
			modifyvm)
				COMPREPLY=( $(compgen -W "--name --memory --ostype --usb --vram
					--acpi --ioapic --hwvirtex --accelerate3d --cpus
					--sataportcount --sataport1 --sataport2 --sataport3 --sataport4
					--nic1 --nictype1 --nic2 --nictype2 --nic3 --nictype3
					--nic4 --nictype4 --nic5 --nictype5 --nic6 --nictype6
					--bridgeadapter1 --bridgeadapter2 --bridgeadapter3 --bridgeadapter4 --bridgeadapter5 --bridgeadapter6
					--vrdp --vrdpport --vrdpauthtype
				" \
				-- ${cur}) )
				;;
			closemedium)
        			COMPREPLY=( $(compgen -W "disk dvd floppy" -- ${cur}) )
				;;
			storageattach)
        			COMPREPLY=( $(compgen -W "--storagectl --device --port --medium --type" -- ${cur}) )
				;;
			*)
	    			COMPREPLY=()
				;;
		esac
            ;;
    esac
}
complete -o filenames -F _VBoxManage VBoxManage
complete -o filenames -F _VBoxManage vboxmanage

# vim: set ft=sh tw=80 sw=4 et :
