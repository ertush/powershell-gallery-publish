
function updatePackages(){
    apt-get update;
    apt-get install git -y;
}

function pullSource(){
    $source_path=$(Join-Path $env:PSModulePath.split(':')[2] $env:INPUT_PAYLOADNAME.Insert(0, '/'));

    git clone $env:INPUT_SOURCE;
    
    cd $env:INPUT_SOURCE.split('/')[4].replace('.git', '');
    
    mkdir $source_path;
    
    cp ./*.ps* $source_path
}

function getSourceVersion(){
    $source_path=$(Join-Path $env:PSModulePath.split(':')[2] $env:INPUT_PAYLOADNAME.Insert(0, '/'));
    
    cd $source_path;

    if(-not $env:INPUT_PAYLOADREQUIREDVERSION -eq $null){

        $env:INPUT_PAYLOADREQUIREDVERSION = $env:INPUT_PAYLOADREQUIREDVERSION
    }
    else 
    {
        # Set version to the next patch version number

        $version = $(cat ./*.psd1 | select-string "ModuleVersion").Line.split(' = ')[1];
        $version = $version.substring(1, $($version.length - 1));
        $env:INPUT_PAYLOADREQUIREDVERSION = $(
            $patch = $([Int]$version.split('.')[$($version.split('.').length - 1)] + 1);
            $version.remove($version.length - 1).insert($($version.length - 1), $patch.ToString())
        );
    }
    
    
}

function publishSource(){
    # Update packages
    updatePackages
    
    # Pull Sources
    pullSource

    # Check payload type script/module
    if($env:INPUT_PAYLOADTYPE -eq 'module'){
        Publish-Module -Name $env:INPUT_PAYLOADNAME -NuGetApi $env:INPUT_NUGETAPIKEY -Repository $env:INPUT_REPOSITORY -RequiredVersion $env:INPUT_PAYLOADREQUIREDVERSION -Force
    }
    else
    {
        Publish-Script -Name $env:INPUT_PAYLOADNAME -NuGetApi $env:INPUT_NUGETAPIKEY -Repository $env:INPUT_REPOSITORY -Force
    } 

    
}

publishSource