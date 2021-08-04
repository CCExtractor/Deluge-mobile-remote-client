

//     final delugeSettings = delugeSettingsFromJson(jsonString);

import 'dart:convert';

DelugeSettings delugeSettingsFromJson(String str) => DelugeSettings.fromJson(json.decode(str));

String delugeSettingsToJson(DelugeSettings data) => json.encode(data.toJson());

class DelugeSettings {
    DelugeSettings({
        this.result,
        this.error,
        this.id,
    });

    Result result;
    dynamic error;
    int id;

    factory DelugeSettings.fromJson(Map<String, dynamic> json) => DelugeSettings(
        result: Result.fromJson(json["result"]),
        error: json["error"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "error": error,
        "id": id,
    };
}

class Result {
    Result({
        this.sendInfo,
        this.infoSent,
        this.daemonPort,
        this.allowRemote,
        this.preAllocateStorage,
        this.downloadLocation,
        this.listenPorts,
        this.listenInterface,
        this.outgoingInterface,
        this.randomPort,
        this.listenRandomPort,
        this.listenUseSysPort,
        this.listenReusePort,
        this.outgoingPorts,
        this.randomOutgoingPorts,
        this.copyTorrentFile,
        this.delCopyTorrentFile,
        this.torrentfilesLocation,
        this.pluginsLocation,
        this.prioritizeFirstLastPieces,
        this.sequentialDownload,
        this.dht,
        this.upnp,
        this.natpmp,
        this.utpex,
        this.lsd,
        this.encInPolicy,
        this.encOutPolicy,
        this.encLevel,
        this.maxConnectionsGlobal,
        this.maxUploadSpeed,
        this.maxDownloadSpeed,
        this.maxUploadSlotsGlobal,
        this.maxHalfOpenConnections,
        this.maxConnectionsPerSecond,
        this.ignoreLimitsOnLocalNetwork,
        this.maxConnectionsPerTorrent,
        this.maxUploadSlotsPerTorrent,
        this.maxUploadSpeedPerTorrent,
        this.maxDownloadSpeedPerTorrent,
        this.enabledPlugins,
        this.addPaused,
        this.maxActiveSeeding,
        this.maxActiveDownloading,
        this.maxActiveLimit,
        this.dontCountSlowTorrents,
        this.queueNewToTop,
        this.stopSeedAtRatio,
        this.removeSeedAtRatio,
        this.stopSeedRatio,
        this.shareRatioLimit,
        this.seedTimeRatioLimit,
        this.seedTimeLimit,
        this.autoManaged,
        this.moveCompleted,
        this.moveCompletedPath,
        this.moveCompletedPathsList,
        this.downloadLocationPathsList,
        this.pathChooserShowChooserButtonOnLocalhost,
        this.pathChooserAutoCompleteEnabled,
        this.pathChooserAcceleratorString,
        this.pathChooserMaxPopupRows,
        this.pathChooserShowHiddenFiles,
        this.newReleaseCheck,
        this.proxy,
        this.peerTos,
        this.rateLimitIpOverhead,
        this.geoipDbLocation,
        this.cacheSize,
        this.cacheExpiry,
        this.autoManagePreferSeeds,
        this.shared,
        this.superSeeding,
        this.autoaddLocation,
    });

    bool sendInfo;
    int infoSent;
    int daemonPort;
    bool allowRemote;
    bool preAllocateStorage;
    String downloadLocation;
    List<String> listenPorts;
    String listenInterface;
    String outgoingInterface;
    String randomPort;
    int listenRandomPort;
    bool listenUseSysPort;
    bool listenReusePort;
    List<String> outgoingPorts;
    String randomOutgoingPorts;
    bool copyTorrentFile;
    bool delCopyTorrentFile;
    String torrentfilesLocation;
    String pluginsLocation;
    bool prioritizeFirstLastPieces;
    bool sequentialDownload;
    bool dht;
    bool upnp;
    bool natpmp;
    bool utpex;
    bool lsd;
    int encInPolicy;
    int encOutPolicy;
    int encLevel;
    int maxConnectionsGlobal;
    int maxUploadSpeed;
    int maxDownloadSpeed;
    int maxUploadSlotsGlobal;
    int maxHalfOpenConnections;
    int maxConnectionsPerSecond;
    bool ignoreLimitsOnLocalNetwork;
    int maxConnectionsPerTorrent;
    int maxUploadSlotsPerTorrent;
    int maxUploadSpeedPerTorrent;
    int maxDownloadSpeedPerTorrent;
    List<dynamic> enabledPlugins;
    bool addPaused;
    int maxActiveSeeding;
    int maxActiveDownloading;
    int maxActiveLimit;
    bool dontCountSlowTorrents;
    bool queueNewToTop;
    bool stopSeedAtRatio;
    bool removeSeedAtRatio;
    int stopSeedRatio;
    int shareRatioLimit;
    int seedTimeRatioLimit;
    int seedTimeLimit;
    bool autoManaged;
    bool moveCompleted;
    String moveCompletedPath;
    List<dynamic> moveCompletedPathsList;
    List<dynamic> downloadLocationPathsList;
    bool pathChooserShowChooserButtonOnLocalhost;
    bool pathChooserAutoCompleteEnabled;
    String pathChooserAcceleratorString;
    int pathChooserMaxPopupRows;
    bool pathChooserShowHiddenFiles;
    bool newReleaseCheck;
    Proxy proxy;
    String peerTos;
    bool rateLimitIpOverhead;
    String geoipDbLocation;
    int cacheSize;
    int cacheExpiry;
    bool autoManagePreferSeeds;
    bool shared;
    bool superSeeding;
    String autoaddLocation;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        sendInfo: json["send_info"],
        infoSent: json["info_sent"],
        daemonPort: json["daemon_port"],
        allowRemote: json["allow_remote"],
        preAllocateStorage: json["pre_allocate_storage"],
        downloadLocation: json["download_location"],
        listenPorts: List<String>.from(json["listen_ports"].map((x) => x)),
        listenInterface: json["listen_interface"],
        outgoingInterface: json["outgoing_interface"],
        randomPort: json["random_port"],
        listenRandomPort: json["listen_random_port"],
        listenUseSysPort: json["listen_use_sys_port"],
        listenReusePort: json["listen_reuse_port"],
        outgoingPorts: List<String>.from(json["outgoing_ports"].map((x) => x)),
        randomOutgoingPorts: json["random_outgoing_ports"],
        copyTorrentFile: json["copy_torrent_file"],
        delCopyTorrentFile: json["del_copy_torrent_file"],
        torrentfilesLocation: json["torrentfiles_location"],
        pluginsLocation: json["plugins_location"],
        prioritizeFirstLastPieces: json["prioritize_first_last_pieces"],
        sequentialDownload: json["sequential_download"],
        dht: json["dht"],
        upnp: json["upnp"],
        natpmp: json["natpmp"],
        utpex: json["utpex"],
        lsd: json["lsd"],
        encInPolicy: json["enc_in_policy"],
        encOutPolicy: json["enc_out_policy"],
        encLevel: json["enc_level"],
        maxConnectionsGlobal: json["max_connections_global"],
        maxUploadSpeed: json["max_upload_speed"],
        maxDownloadSpeed: json["max_download_speed"],
        maxUploadSlotsGlobal: json["max_upload_slots_global"],
        maxHalfOpenConnections: json["max_half_open_connections"],
        maxConnectionsPerSecond: json["max_connections_per_second"],
        ignoreLimitsOnLocalNetwork: json["ignore_limits_on_local_network"],
        maxConnectionsPerTorrent: json["max_connections_per_torrent"],
        maxUploadSlotsPerTorrent: json["max_upload_slots_per_torrent"],
        maxUploadSpeedPerTorrent: json["max_upload_speed_per_torrent"],
        maxDownloadSpeedPerTorrent: json["max_download_speed_per_torrent"],
        enabledPlugins: List<dynamic>.from(json["enabled_plugins"].map((x) => x)),
        addPaused: json["add_paused"],
        maxActiveSeeding: json["max_active_seeding"],
        maxActiveDownloading: json["max_active_downloading"],
        maxActiveLimit: json["max_active_limit"],
        dontCountSlowTorrents: json["dont_count_slow_torrents"],
        queueNewToTop: json["queue_new_to_top"],
        stopSeedAtRatio: json["stop_seed_at_ratio"],
        removeSeedAtRatio: json["remove_seed_at_ratio"],
        stopSeedRatio: json["stop_seed_ratio"],
        shareRatioLimit: json["share_ratio_limit"],
        seedTimeRatioLimit: json["seed_time_ratio_limit"],
        seedTimeLimit: json["seed_time_limit"],
        autoManaged: json["auto_managed"],
        moveCompleted: json["move_completed"],
        moveCompletedPath: json["move_completed_path"],
        moveCompletedPathsList: List<dynamic>.from(json["move_completed_paths_list"].map((x) => x)),
        downloadLocationPathsList: List<dynamic>.from(json["download_location_paths_list"].map((x) => x)),
        pathChooserShowChooserButtonOnLocalhost: json["path_chooser_show_chooser_button_on_localhost"],
        pathChooserAutoCompleteEnabled: json["path_chooser_auto_complete_enabled"],
        pathChooserAcceleratorString: json["path_chooser_accelerator_string"],
        pathChooserMaxPopupRows: json["path_chooser_max_popup_rows"],
        pathChooserShowHiddenFiles: json["path_chooser_show_hidden_files"],
        newReleaseCheck: json["new_release_check"],
        proxy: Proxy.fromJson(json["proxy"]),
        peerTos: json["peer_tos"],
        rateLimitIpOverhead: json["rate_limit_ip_overhead"],
        geoipDbLocation: json["geoip_db_location"],
        cacheSize: json["cache_size"],
        cacheExpiry: json["cache_expiry"],
        autoManagePreferSeeds: json["auto_manage_prefer_seeds"],
        shared: json["shared"],
        superSeeding: json["super_seeding"],
        autoaddLocation: json["autoadd_location"],
    );

    Map<String, dynamic> toJson() => {
        "send_info": sendInfo,
        "info_sent": infoSent,
        "daemon_port": daemonPort,
        "allow_remote": allowRemote,
        "pre_allocate_storage": preAllocateStorage,
        "download_location": downloadLocation,
        "listen_ports": List<dynamic>.from(listenPorts.map((x) => x)),
        "listen_interface": listenInterface,
        "outgoing_interface": outgoingInterface,
        "random_port": randomPort,
        "listen_random_port": listenRandomPort,
        "listen_use_sys_port": listenUseSysPort,
        "listen_reuse_port": listenReusePort,
        "outgoing_ports": List<dynamic>.from(outgoingPorts.map((x) => x)),
        "random_outgoing_ports": randomOutgoingPorts,
        "copy_torrent_file": copyTorrentFile,
        "del_copy_torrent_file": delCopyTorrentFile,
        "torrentfiles_location": torrentfilesLocation,
        "plugins_location": pluginsLocation,
        "prioritize_first_last_pieces": prioritizeFirstLastPieces,
        "sequential_download": sequentialDownload,
        "dht": dht,
        "upnp": upnp,
        "natpmp": natpmp,
        "utpex": utpex,
        "lsd": lsd,
        "enc_in_policy": encInPolicy,
        "enc_out_policy": encOutPolicy,
        "enc_level": encLevel,
        "max_connections_global": maxConnectionsGlobal,
        "max_upload_speed": maxUploadSpeed,
        "max_download_speed": maxDownloadSpeed,
        "max_upload_slots_global": maxUploadSlotsGlobal,
        "max_half_open_connections": maxHalfOpenConnections,
        "max_connections_per_second": maxConnectionsPerSecond,
        "ignore_limits_on_local_network": ignoreLimitsOnLocalNetwork,
        "max_connections_per_torrent": maxConnectionsPerTorrent,
        "max_upload_slots_per_torrent": maxUploadSlotsPerTorrent,
        "max_upload_speed_per_torrent": maxUploadSpeedPerTorrent,
        "max_download_speed_per_torrent": maxDownloadSpeedPerTorrent,
        "enabled_plugins": List<dynamic>.from(enabledPlugins.map((x) => x)),
        "add_paused": addPaused,
        "max_active_seeding": maxActiveSeeding,
        "max_active_downloading": maxActiveDownloading,
        "max_active_limit": maxActiveLimit,
        "dont_count_slow_torrents": dontCountSlowTorrents,
        "queue_new_to_top": queueNewToTop,
        "stop_seed_at_ratio": stopSeedAtRatio,
        "remove_seed_at_ratio": removeSeedAtRatio,
        "stop_seed_ratio": stopSeedRatio,
        "share_ratio_limit": shareRatioLimit,
        "seed_time_ratio_limit": seedTimeRatioLimit,
        "seed_time_limit": seedTimeLimit,
        "auto_managed": autoManaged,
        "move_completed": moveCompleted,
        "move_completed_path": moveCompletedPath,
        "move_completed_paths_list": List<dynamic>.from(moveCompletedPathsList.map((x) => x)),
        "download_location_paths_list": List<dynamic>.from(downloadLocationPathsList.map((x) => x)),
        "path_chooser_show_chooser_button_on_localhost": pathChooserShowChooserButtonOnLocalhost,
        "path_chooser_auto_complete_enabled": pathChooserAutoCompleteEnabled,
        "path_chooser_accelerator_string": pathChooserAcceleratorString,
        "path_chooser_max_popup_rows": pathChooserMaxPopupRows,
        "path_chooser_show_hidden_files": pathChooserShowHiddenFiles,
        "new_release_check": newReleaseCheck,
        "proxy": proxy.toJson(),
        "peer_tos": peerTos,
        "rate_limit_ip_overhead": rateLimitIpOverhead,
        "geoip_db_location": geoipDbLocation,
        "cache_size": cacheSize,
        "cache_expiry": cacheExpiry,
        "auto_manage_prefer_seeds": autoManagePreferSeeds,
        "shared": shared,
        "super_seeding": superSeeding,
        "autoadd_location": autoaddLocation,
    };
}

class Proxy {
    Proxy({
        this.anonymousMode,
        this.forceProxy,
        this.hostname,
        this.password,
        this.port,
        this.proxyHostnames,
        this.proxyPeerConnections,
        this.proxyTrackerConnections,
        this.type,
        this.username,
    });

    bool anonymousMode;
    bool forceProxy;
    String hostname;
    String password;
    String port;
    bool proxyHostnames;
    bool proxyPeerConnections;
    bool proxyTrackerConnections;
    int type;
    String username;

    factory Proxy.fromJson(Map<String, dynamic> json) => Proxy(
        anonymousMode: json["anonymous_mode"],
        forceProxy: json["force_proxy"],
        hostname: json["hostname"],
        password: json["password"],
        port: json["port"],
        proxyHostnames: json["proxy_hostnames"],
        proxyPeerConnections: json["proxy_peer_connections"],
        proxyTrackerConnections: json["proxy_tracker_connections"],
        type: json["type"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "anonymous_mode": anonymousMode,
        "force_proxy": forceProxy,
        "hostname": hostname,
        "password": password,
        "port": port,
        "proxy_hostnames": proxyHostnames,
        "proxy_peer_connections": proxyPeerConnections,
        "proxy_tracker_connections": proxyTrackerConnections,
        "type": type,
        "username": username,
    };
}
