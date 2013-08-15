

# The contets of this file is prepended to all puppet manifests

if ( $::building == '1' ){
  $enabled=false
}else{
  $enabled=true
}
