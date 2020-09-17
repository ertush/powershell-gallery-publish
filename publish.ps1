
function updatePackages(){
    apt update ;
    apt install git ;
}

function pullSource(){
    git clone $env:INPUT_SOURCE;
    cd $env:INPUT_SOURCE.split('/')[4].replace('.git', '');
    cp ./*.ps* $(echo $env:PSModulePath).split(':')[2]
}

function publishSource(){
    # Update packages
    updatePackages
    
    # Pull Sources
    pullSource

    # Check payload type script/module
    if($env:INPUT_PAYLOADTYPE -eq 'module'){
        Publish-Module -Name $env:INPUT_PAYLOADNAME -NuGetApi $env:INPUT_NUGETAPIKEY -Repository $env:INPUT_REPOSITORY -RequiredVersion -Force
    }
    else
    {
        Publish-Script -Name $env:INPUT_PAYLOADNAME -NuGetApi $env:INPUT_NUGETAPIKEY -Repository $env:INPUT_REPOSITORY -Force
    } 
}

publishSource