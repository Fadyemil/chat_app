import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/models/message_model.dart';
import 'package:chat_app/core/utlie/date_time.dart';
import 'package:chat_app/core/utlie/photo_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupMessageCard extends StatelessWidget {
  const GroupMessageCard({
    super.key,
    required this.message,
  });
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    bool isMe = message.fromId == FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(message.fromId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (message.type == 'text') {
            return Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                isMe
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.message_edit))
                    : const SizedBox(),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(isMe ? 16 : 0),
                    bottomRight: Radius.circular(isMe ? 0 : 16),
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                  )),
                  color: isMe
                      ? Theme.of(context).colorScheme.background
                      : Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !isMe
                              ? Text(
                                  snapshot.data!.data()!['name'],
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )
                              : Container(),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(message.msg!),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isMe
                                  ? const Icon(
                                      Iconsax.tick_circle,
                                      color: Colors.blueAccent,
                                      size: 18,
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                MyDateTime.timeDate(
                                    time: message.createdAt.toString()),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (message.type == 'image') {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoViewScreen(
                        image: message.msg!,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    isMe
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.message_edit))
                        : const SizedBox(),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(isMe ? 16 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 16),
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                      )),
                      color: isMe
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).colorScheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.sizeOf(context).width / 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              !isMe
                                  ? Text(
                                      snapshot.data!.data()!['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                child: CachedNetworkImage(
                                  imageUrl: message.msg!,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isMe
                                      ? const Icon(
                                          Iconsax.tick_circle,
                                          color: Colors.blueAccent,
                                          size: 18,
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    MyDateTime.timeDate(
                                        time: message.createdAt.toString()),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
