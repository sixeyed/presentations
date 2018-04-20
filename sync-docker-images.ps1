param(
    [string] $ImageListPath,    
    [string] $SourceRegistry = '',
    [string] $TargetRegistry = ''
)

$images = (Get-Content $imageListPath)
Write-Output "Loaded image list. Image count: $($images.Length)."
Write-Output "Pulling images. Source registry: $SourceRegistry"

foreach ($tag in $images) {

    Write-Output "** Pulling tag: $tag"

    $sourceTag = $tag
    if ($SourceRegistry.Length -gt 0) {
        $sourceTag = "$($SourceRegistry)/$($tag)"
    }

    & docker $config image pull $sourceTag
    if ($sourceTag -ne $tag) {
        & docker $config image pull $tag
        & docker $config image rm $sourceTag
    }
}

if ($TargetRegistry.Length -gt 0) {

    Write-Output "Pushing images. Target registry: $TargetRegistry."

    foreach ($tag in $images) {
        Write-Output "** Pushing tag: $tag"
        $targetTag = "$($TargetRegistry)/$($tag)"
        & docker $config image tag $tag $targetTag
        & docker $config image push $targetTag
    }
}