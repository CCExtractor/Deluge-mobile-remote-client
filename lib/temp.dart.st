Container(child: ListView.builder(itemBuilder: (context, index) {
          Future.delayed(const Duration(seconds: 2), () {
            Map<String, Result> res_torrent = new Map();
            res_torrent = torrent.result;
            // it is the key that is basically idententity of list
            String key = res_torrent.keys.elementAt(index);

            //inside the result array
            Result inside_res = res_torrent[key];
            print(inside_res.name);
            return ListTile(
              title: Text(
                inside_res.name,
                style: TextStyle(color: Colors.black),
              ),
            );
          });
        }))


        //----
          if (snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ));
              }