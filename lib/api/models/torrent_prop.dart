
//     final properties = propertiesFromJson(jsonString);

import 'dart:convert';

Map<String, Properties> propertiesFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Properties>(k, Properties.fromJson(v)));

String propertiesToJson(Map<String, Properties> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Properties {
    Properties({
        this.activeTime,
        this.seedingTime,
        this.finishedTime,
        this.allTimeDownload,
        this.storageMode,
        this.distributedCopies,
        this.downloadPayloadRate,
        this.filePriorities,
        this.hash,
        this.autoManaged,
        this.isAutoManaged,
        this.isFinished,
        this.maxConnections,
        this.maxDownloadSpeed,
        this.maxUploadSlots,
        this.maxUploadSpeed,
        this.message,
        this.moveOnCompletedPath,
        this.moveOnCompleted,
        this.moveCompletedPath,
        this.moveCompleted,
        this.nextAnnounce,
        this.numPeers,
        this.numSeeds,
        this.owner,
        this.paused,
        this.prioritizeFirstLast,
        this.prioritizeFirstLastPieces,
        this.sequentialDownload,
        this.progress,
        this.shared,
        this.removeAtRatio,
        this.savePath,
        this.downloadLocation,
        this.seedsPeersRatio,
        this.seedRank,
        this.state,
        this.stopAtRatio,
        this.stopRatio,
        this.timeAdded,
        this.totalDone,
        this.totalPayloadDownload,
        this.totalPayloadUpload,
        this.totalPeers,
        this.totalSeeds,
        this.totalUploaded,
        this.totalWanted,
        this.totalRemaining,
        this.tracker,
        this.trackerHost,
        this.trackers,
        this.trackerStatus,
        this.uploadPayloadRate,
        this.comment,
        this.creator,
        this.numFiles,
        this.numPieces,
        this.pieceLength,
        this.private,
        this.totalSize,
        this.eta,
        this.fileProgress,
        this.files,
        this.origFiles,
        this.isSeed,
        this.peers,
        this.queue,
        this.ratio,
        this.completedTime,
        this.lastSeenComplete,
        this.name,
        this.pieces,
        this.seedMode,
        this.superSeeding,
        this.timeSinceDownload,
        this.timeSinceUpload,
        this.timeSinceTransfer,
    });

    int activeTime;
    int seedingTime;
    int finishedTime;
    int allTimeDownload;
    String storageMode;
    double distributedCopies;
    int downloadPayloadRate;
    List<int> filePriorities;
    String hash;
    bool autoManaged;
    bool isAutoManaged;
    bool isFinished;
    int maxConnections;
    int maxDownloadSpeed;
    int maxUploadSlots;
    int maxUploadSpeed;
    String message;
    String moveOnCompletedPath;
    bool moveOnCompleted;
    String moveCompletedPath;
    bool moveCompleted;
    int nextAnnounce;
    int numPeers;
    int numSeeds;
    String owner;
    bool paused;
    bool prioritizeFirstLast;
    bool prioritizeFirstLastPieces;
    bool sequentialDownload;
    double progress;
    bool shared;
    bool removeAtRatio;
    String savePath;
    String downloadLocation;
    double seedsPeersRatio;
    int seedRank;
    String state;
    bool stopAtRatio;
    int stopRatio;
    int timeAdded;
    int totalDone;
    int totalPayloadDownload;
    int totalPayloadUpload;
    int totalPeers;
    int totalSeeds;
    int totalUploaded;
    int totalWanted;
    int totalRemaining;
    String tracker;
    String trackerHost;
    List<Tracker> trackers;
    String trackerStatus;
    int uploadPayloadRate;
    String comment;
    String creator;
    int numFiles;
    int numPieces;
    int pieceLength;
    bool private;
    int totalSize;
    int eta;
    List<double> fileProgress;
    List<FileElement> files;
    List<FileElement> origFiles;
    bool isSeed;
    List<dynamic> peers;
    int queue;
    double ratio;
    int completedTime;
    int lastSeenComplete;
    String name;
    dynamic pieces;
    bool seedMode;
    bool superSeeding;
    int timeSinceDownload;
    int timeSinceUpload;
    int timeSinceTransfer;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        activeTime: json["active_time"],
        seedingTime: json["seeding_time"],
        finishedTime: json["finished_time"],
        allTimeDownload: json["all_time_download"],
        storageMode: json["storage_mode"],
        distributedCopies: json["distributed_copies"],
        downloadPayloadRate: json["download_payload_rate"],
        filePriorities: List<int>.from(json["file_priorities"].map((x) => x)),
        hash: json["hash"],
        autoManaged: json["auto_managed"],
        isAutoManaged: json["is_auto_managed"],
        isFinished: json["is_finished"],
        maxConnections: json["max_connections"],
        maxDownloadSpeed: json["max_download_speed"],
        maxUploadSlots: json["max_upload_slots"],
        maxUploadSpeed: json["max_upload_speed"],
        message: json["message"],
        moveOnCompletedPath: json["move_on_completed_path"],
        moveOnCompleted: json["move_on_completed"],
        moveCompletedPath: json["move_completed_path"],
        moveCompleted: json["move_completed"],
        nextAnnounce: json["next_announce"],
        numPeers: json["num_peers"],
        numSeeds: json["num_seeds"],
        owner: json["owner"],
        paused: json["paused"],
        prioritizeFirstLast: json["prioritize_first_last"],
        prioritizeFirstLastPieces: json["prioritize_first_last_pieces"],
        sequentialDownload: json["sequential_download"],
        progress: json["progress"],
        shared: json["shared"],
        removeAtRatio: json["remove_at_ratio"],
        savePath: json["save_path"],
        downloadLocation: json["download_location"],
        seedsPeersRatio: json["seeds_peers_ratio"],
        seedRank: json["seed_rank"],
        state: json["state"],
        stopAtRatio: json["stop_at_ratio"],
        stopRatio: json["stop_ratio"],
        timeAdded: json["time_added"],
        totalDone: json["total_done"],
        totalPayloadDownload: json["total_payload_download"],
        totalPayloadUpload: json["total_payload_upload"],
        totalPeers: json["total_peers"],
        totalSeeds: json["total_seeds"],
        totalUploaded: json["total_uploaded"],
        totalWanted: json["total_wanted"],
        totalRemaining: json["total_remaining"],
        tracker: json["tracker"],
        trackerHost: json["tracker_host"],
        trackers: List<Tracker>.from(json["trackers"].map((x) => Tracker.fromJson(x))),
        trackerStatus: json["tracker_status"],
        uploadPayloadRate: json["upload_payload_rate"],
        comment: json["comment"],
        creator: json["creator"],
        numFiles: json["num_files"],
        numPieces: json["num_pieces"],
        pieceLength: json["piece_length"],
        private: json["private"],
        totalSize: json["total_size"],
        eta: json["eta"],
        fileProgress: List<double>.from(json["file_progress"].map((x) => x)),
        files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        origFiles: List<FileElement>.from(json["orig_files"].map((x) => FileElement.fromJson(x))),
        isSeed: json["is_seed"],
        peers: List<dynamic>.from(json["peers"].map((x) => x)),
        queue: json["queue"],
        ratio: json["ratio"],
        completedTime: json["completed_time"],
        lastSeenComplete: json["last_seen_complete"],
        name: json["name"],
        pieces: json["pieces"],
        seedMode: json["seed_mode"],
        superSeeding: json["super_seeding"],
        timeSinceDownload: json["time_since_download"],
        timeSinceUpload: json["time_since_upload"],
        timeSinceTransfer: json["time_since_transfer"],
    );

    Map<String, dynamic> toJson() => {
        "active_time": activeTime,
        "seeding_time": seedingTime,
        "finished_time": finishedTime,
        "all_time_download": allTimeDownload,
        "storage_mode": storageMode,
        "distributed_copies": distributedCopies,
        "download_payload_rate": downloadPayloadRate,
        "file_priorities": List<dynamic>.from(filePriorities.map((x) => x)),
        "hash": hash,
        "auto_managed": autoManaged,
        "is_auto_managed": isAutoManaged,
        "is_finished": isFinished,
        "max_connections": maxConnections,
        "max_download_speed": maxDownloadSpeed,
        "max_upload_slots": maxUploadSlots,
        "max_upload_speed": maxUploadSpeed,
        "message": message,
        "move_on_completed_path": moveOnCompletedPath,
        "move_on_completed": moveOnCompleted,
        "move_completed_path": moveCompletedPath,
        "move_completed": moveCompleted,
        "next_announce": nextAnnounce,
        "num_peers": numPeers,
        "num_seeds": numSeeds,
        "owner": owner,
        "paused": paused,
        "prioritize_first_last": prioritizeFirstLast,
        "prioritize_first_last_pieces": prioritizeFirstLastPieces,
        "sequential_download": sequentialDownload,
        "progress": progress,
        "shared": shared,
        "remove_at_ratio": removeAtRatio,
        "save_path": savePath,
        "download_location": downloadLocation,
        "seeds_peers_ratio": seedsPeersRatio,
        "seed_rank": seedRank,
        "state": state,
        "stop_at_ratio": stopAtRatio,
        "stop_ratio": stopRatio,
        "time_added": timeAdded,
        "total_done": totalDone,
        "total_payload_download": totalPayloadDownload,
        "total_payload_upload": totalPayloadUpload,
        "total_peers": totalPeers,
        "total_seeds": totalSeeds,
        "total_uploaded": totalUploaded,
        "total_wanted": totalWanted,
        "total_remaining": totalRemaining,
        "tracker": tracker,
        "tracker_host": trackerHost,
        "trackers": List<dynamic>.from(trackers.map((x) => x.toJson())),
        "tracker_status": trackerStatus,
        "upload_payload_rate": uploadPayloadRate,
        "comment": comment,
        "creator": creator,
        "num_files": numFiles,
        "num_pieces": numPieces,
        "piece_length": pieceLength,
        "private": private,
        "total_size": totalSize,
        "eta": eta,
        "file_progress": List<dynamic>.from(fileProgress.map((x) => x)),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "orig_files": List<dynamic>.from(origFiles.map((x) => x.toJson())),
        "is_seed": isSeed,
        "peers": List<dynamic>.from(peers.map((x) => x)),
        "queue": queue,
        "ratio": ratio,
        "completed_time": completedTime,
        "last_seen_complete": lastSeenComplete,
        "name": name,
        "pieces": pieces,
        "seed_mode": seedMode,
        "super_seeding": superSeeding,
        "time_since_download": timeSinceDownload,
        "time_since_upload": timeSinceUpload,
        "time_since_transfer": timeSinceTransfer,
    };
}

class FileElement {
    FileElement({
        this.index,
        this.path,
        this.size,
        this.offset,
    });

    int index;
    String path;
    int size;
    int offset;

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        index: json["index"],
        path: json["path"],
        size: json["size"],
        offset: json["offset"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "path": path,
        "size": size,
        "offset": offset,
    };
}

class Tracker {
    Tracker({
        this.url,
        this.trackerid,
        this.message,
        this.lastError,
        this.nextAnnounce,
        this.minAnnounce,
        this.scrapeIncomplete,
        this.scrapeComplete,
        this.scrapeDownloaded,
        this.tier,
        this.failLimit,
        this.fails,
        this.source,
        this.verified,
        this.updating,
        this.startSent,
        this.completeSent,
        this.sendStats,
    });

    String url;
    String trackerid;
    String message;
    LastError lastError;
    dynamic nextAnnounce;
    dynamic minAnnounce;
    int scrapeIncomplete;
    int scrapeComplete;
    int scrapeDownloaded;
    int tier;
    int failLimit;
    int fails;
    int source;
    bool verified;
    bool updating;
    bool startSent;
    bool completeSent;
    bool sendStats;

    factory Tracker.fromJson(Map<String, dynamic> json) => Tracker(
        url: json["url"],
        trackerid: json["trackerid"],
        message: json["message"],
        lastError: LastError.fromJson(json["last_error"]),
        nextAnnounce: json["next_announce"],
        minAnnounce: json["min_announce"],
        scrapeIncomplete: json["scrape_incomplete"],
        scrapeComplete: json["scrape_complete"],
        scrapeDownloaded: json["scrape_downloaded"],
        tier: json["tier"],
        failLimit: json["fail_limit"],
        fails: json["fails"],
        source: json["source"],
        verified: json["verified"],
        updating: json["updating"],
        startSent: json["start_sent"],
        completeSent: json["complete_sent"],
        sendStats: json["send_stats"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "trackerid": trackerid,
        "message": message,
        "last_error": lastError.toJson(),
        "next_announce": nextAnnounce,
        "min_announce": minAnnounce,
        "scrape_incomplete": scrapeIncomplete,
        "scrape_complete": scrapeComplete,
        "scrape_downloaded": scrapeDownloaded,
        "tier": tier,
        "fail_limit": failLimit,
        "fails": fails,
        "source": source,
        "verified": verified,
        "updating": updating,
        "start_sent": startSent,
        "complete_sent": completeSent,
        "send_stats": sendStats,
    };
}

class LastError {
    LastError({
        this.value,
        this.category,
    });

    int value;
    String category;

    factory LastError.fromJson(Map<String, dynamic> json) => LastError(
        value: json["value"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "category": category,
    };
}
