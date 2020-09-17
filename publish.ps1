
function updatePackages(){
    apt update ;
    apt install git -y;
}

function pullSource(){
    git clone $env:INPUT_SOURCE;
    cd $env:INPUT_SOURCE.split('/')[4].replace('.git', '');
    cp ./*.ps* $(echo $env:PSModulePath).split(':')[2]
}

function publishSource(){
    # # Update packages
    # updatePackages
    
    # # Pull Sources
    # pullSource

    # # Check payload type script/module
    # if($env:INPUT_PAYLOADTYPE -eq 'module'){
    #     Publish-Module -Name $env:INPUT_PAYLOADNAME -NuGetApi $env:INPUT_NUGETAPIKEY -Repository $env:INPUT_REPOSITORY -RequiredVersion -Force
    # }
    # else
    # {
    #     Publish-Script -Name $env:INPUT_PAYLOADNAME -NuGetApi $env:INPUT_NUGETAPIKEY -Repository $env:INPUT_REPOSITORY -Force
    # } 

    echo "API_KEY"$env:INPUT_NUGETAPIKEY;
    echo "PAYLOAD_NAME"$env:INPUT_PAYLOADNAME;
    echo "PAYLOAD_TYPE"$env:INPUT_PAYLOADTYPE;
    echo "REPOSITORY"$env:INPUT_REPOSITORY;
    echo "INPUT_SOURCE"$env:INPUT_SOURCE;
    
}

publishSource