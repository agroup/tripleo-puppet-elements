class {"heat::engine":
    enabled => $enabled,
    heat_metadata_server_url => "$::heat_metadata_server_url",
    heat_waitcondition_server_url => "$::heat_waitcondition_server_url",
    heat_watch_server_url => "$::heat_heat_watch_server_url",
}
