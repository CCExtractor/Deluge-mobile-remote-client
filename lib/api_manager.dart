
import 'dart:convert';

ThinClient thinClientFromJson(String str) => ThinClient.fromJson(json.decode(str));

String thinClientToJson(ThinClient data) => json.encode(data.toJson());

class ThinClient {
    ThinClient({
        this.id,
        this.result,
        this.error,
    });

    int id;
    Map<String, Result> result;
    dynamic error;

    factory ThinClient.fromJson(Map<String, dynamic> json) => ThinClient(
        id: json["id"],
        result: Map.from(json["result"]).map((k, v) => MapEntry<String, Result>(k, Result.fromJson(v))),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "result": Map.from(result).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "error": error,
    };
}

class Result {
    Result({
        this.comment,
        this.activeTime,
        this.isSeed,
        this.hash,
        this.uploadPayloadRate,
        this.moveCompletedPath,
        this.private,
        this.totalPayloadUpload,
        this.paused,
        this.seedRank,
        this.seedingTime,
        this.maxUploadSlots,
        this.prioritizeFirstLast,
        this.distributedCopies,
        this.downloadPayloadRate,
        this.message,
        this.numPeers,
        this.maxDownloadSpeed,
        this.maxConnections,
        this.compact,
        this.ratio,
        this.totalPeers,
        this.totalSize,
        this.totalWanted,
        this.state,
        this.filePriorities,
        this.maxUploadSpeed,
        this.removeAtRatio,
        this.tracker,
        this.savePath,
        this.progress,
        this.timeAdded,
        this.trackerHost,
        this.totalUploaded,
        this.files,
        this.totalDone,
        this.numPieces,
        this.trackerStatus,
        this.totalSeeds,
        this.moveOnCompleted,
        this.nextAnnounce,
        this.stopAtRatio,
        this.fileProgress,
        this.moveCompleted,
        this.pieceLength,
        this.allTimeDownload,
        this.moveOnCompletedPath,
        this.numSeeds,
        this.peers,
        this.name,
        this.trackers,
        this.totalPayloadDownload,
        this.isAutoManaged,
        this.seedsPeersRatio,
        this.queue,
        this.numFiles,
        this.eta,
        this.stopRatio,
        this.isFinished,
    });

    String comment;
    int activeTime;
    bool isSeed;
    String hash;
    int uploadPayloadRate;
    String moveCompletedPath;
    bool private;
    int totalPayloadUpload;
    bool paused;
    int seedRank;
    int seedingTime;
    int maxUploadSlots;
    bool prioritizeFirstLast;
    double distributedCopies;
    int downloadPayloadRate;
    String message;
    int numPeers;
    int maxDownloadSpeed;
    int maxConnections;
    bool compact;
    double ratio;
    int totalPeers;
    int totalSize;
    int totalWanted;
    String state;
    List<int> filePriorities;
    int maxUploadSpeed;
    bool removeAtRatio;
    String tracker;
    String savePath;
    double progress;
    double timeAdded;
    String trackerHost;
    int totalUploaded;
    List<FileElement> files;
    int totalDone;
    int numPieces;
    String trackerStatus;
    int totalSeeds;
    bool moveOnCompleted;
    int nextAnnounce;
    bool stopAtRatio;
    List<double> fileProgress;
    bool moveCompleted;
    int pieceLength;
    int allTimeDownload;
    String moveOnCompletedPath;
    int numSeeds;
    List<dynamic> peers;
    String name;
    List<Tracker> trackers;
    int totalPayloadDownload;
    bool isAutoManaged;
    double seedsPeersRatio;
    int queue;
    int numFiles;
    int eta;
    double stopRatio;
    bool isFinished;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        comment: json["comment"],
        activeTime: json["active_time"],
        isSeed: json["is_seed"],
        hash: json["hash"],
        uploadPayloadRate: json["upload_payload_rate"],
        moveCompletedPath: json["move_completed_path"],
        private: json["private"],
        totalPayloadUpload: json["total_payload_upload"],
        paused: json["paused"],
        seedRank: json["seed_rank"],
        seedingTime: json["seeding_time"],
        maxUploadSlots: json["max_upload_slots"],
        prioritizeFirstLast: json["prioritize_first_last"],
        distributedCopies: json["distributed_copies"].toDouble(),
        downloadPayloadRate: json["download_payload_rate"],
        message: json["message"],
        numPeers: json["num_peers"],
        maxDownloadSpeed: json["max_download_speed"],
        maxConnections: json["max_connections"],
        compact: json["compact"],
        ratio: json["ratio"],
        totalPeers: json["total_peers"],
        totalSize: json["total_size"],
        totalWanted: json["total_wanted"],
        state: json["state"],
        filePriorities: List<int>.from(json["file_priorities"].map((x) => x)),
        maxUploadSpeed: json["max_upload_speed"],
        removeAtRatio: json["remove_at_ratio"],
        tracker: json["tracker"],
        savePath: json["save_path"],
        progress: json["progress"].toDouble(),
        timeAdded: json["time_added"],
        trackerHost: json["tracker_host"],
        totalUploaded: json["total_uploaded"],
        files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        totalDone: json["total_done"],
        numPieces: json["num_pieces"],
        trackerStatus: json["tracker_status"],
        totalSeeds: json["total_seeds"],
        moveOnCompleted: json["move_on_completed"],
        nextAnnounce: json["next_announce"],
        stopAtRatio: json["stop_at_ratio"],
        fileProgress: List<double>.from(json["file_progress"].map((x) => x.toDouble())),
        moveCompleted: json["move_completed"],
        pieceLength: json["piece_length"],
        allTimeDownload: json["all_time_download"],
        moveOnCompletedPath: json["move_on_completed_path"],
        numSeeds: json["num_seeds"],
        peers: List<dynamic>.from(json["peers"].map((x) => x)),
        name: json["name"],
        trackers: List<Tracker>.from(json["trackers"].map((x) => Tracker.fromJson(x))),
        totalPayloadDownload: json["total_payload_download"],
        isAutoManaged: json["is_auto_managed"],
        seedsPeersRatio: json["seeds_peers_ratio"].toDouble(),
        queue: json["queue"],
        numFiles: json["num_files"],
        eta: json["eta"],
        stopRatio: json["stop_ratio"],
        isFinished: json["is_finished"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "active_time": activeTime,
        "is_seed": isSeed,
        "hash": hash,
        "upload_payload_rate": uploadPayloadRate,
        "move_completed_path": moveCompletedPath,
        "private": private,
        "total_payload_upload": totalPayloadUpload,
        "paused": paused,
        "seed_rank": seedRank,
        "seeding_time": seedingTime,
        "max_upload_slots": maxUploadSlots,
        "prioritize_first_last": prioritizeFirstLast,
        "distributed_copies": distributedCopies,
        "download_payload_rate": downloadPayloadRate,
        "message": message,
        "num_peers": numPeers,
        "max_download_speed": maxDownloadSpeed,
        "max_connections": maxConnections,
        "compact": compact,
        "ratio": ratio,
        "total_peers": totalPeers,
        "total_size": totalSize,
        "total_wanted": totalWanted,
        "state": state,
        "file_priorities": List<dynamic>.from(filePriorities.map((x) => x)),
        "max_upload_speed": maxUploadSpeed,
        "remove_at_ratio": removeAtRatio,
        "tracker": tracker,
        "save_path": savePath,
        "progress": progress,
        "time_added": timeAdded,
        "tracker_host": trackerHost,
        "total_uploaded": totalUploaded,
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "total_done": totalDone,
        "num_pieces": numPieces,
        "tracker_status": trackerStatus,
        "total_seeds": totalSeeds,
        "move_on_completed": moveOnCompleted,
        "next_announce": nextAnnounce,
        "stop_at_ratio": stopAtRatio,
        "file_progress": List<dynamic>.from(fileProgress.map((x) => x)),
        "move_completed": moveCompleted,
        "piece_length": pieceLength,
        "all_time_download": allTimeDownload,
        "move_on_completed_path": moveOnCompletedPath,
        "num_seeds": numSeeds,
        "peers": List<dynamic>.from(peers.map((x) => x)),
        "name": name,
        "trackers": List<dynamic>.from(trackers.map((x) => x.toJson())),
        "total_payload_download": totalPayloadDownload,
        "is_auto_managed": isAutoManaged,
        "seeds_peers_ratio": seedsPeersRatio,
        "queue": queue,
        "num_files": numFiles,
        "eta": eta,
        "stop_ratio": stopRatio,
        "is_finished": isFinished,
    };
}

class FileElement {
    FileElement({
        this.index,
        this.path,
        this.offset,
        this.size,
    });

    int index;
    String path;
    int offset;
    int size;

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        index: json["index"],
        path: json["path"],
        offset: json["offset"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "path": path,
        "offset": offset,
        "size": size,
    };
}

class Tracker {
    Tracker({
        this.sendStats,
        this.fails,
        this.verified,
        this.minAnnounce,
        this.url,
        this.failLimit,
        this.nextAnnounce,
        this.completeSent,
        this.source,
        this.startSent,
        this.tier,
        this.updating,
    });

    bool sendStats;
    int fails;
    bool verified;
    dynamic minAnnounce;
    String url;
    int failLimit;
    dynamic nextAnnounce;
    bool completeSent;
    int source;
    bool startSent;
    int tier;
    bool updating;

    factory Tracker.fromJson(Map<String, dynamic> json) => Tracker(
        sendStats: json["send_stats"],
        fails: json["fails"],
        verified: json["verified"],
        minAnnounce: json["min_announce"],
        url: json["url"],
        failLimit: json["fail_limit"],
        nextAnnounce: json["next_announce"],
        completeSent: json["complete_sent"],
        source: json["source"],
        startSent: json["start_sent"],
        tier: json["tier"],
        updating: json["updating"],
    );

    Map<String, dynamic> toJson() => {
        "send_stats": sendStats,
        "fails": fails,
        "verified": verified,
        "min_announce": minAnnounce,
        "url": url,
        "fail_limit": failLimit,
        "next_announce": nextAnnounce,
        "complete_sent": completeSent,
        "source": source,
        "start_sent": startSent,
        "tier": tier,
        "updating": updating,
    };
}
