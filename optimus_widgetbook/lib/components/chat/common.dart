import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

const avatar1 = OptimusAvatar(
  title: 'User 1',
  imageUrl: _avatarUrl,
);

const avatar2 = OptimusAvatar(
  title: 'You',
);

const avatar3 = OptimusAvatar(
  title: 'User 3',
  imageUrl: _avatar2Url,
);

final organizationAvatar = Stack(
  children: [
    avatar3,
    Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: 16,
        height: 16,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
            image: NetworkImage(_organizationAvatarUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  ],
);
const _avatarUrl =
    'https://images.unsplash.com/photo-1560525821-d5615ef80c69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=512&q=80';

const _avatar2Url =
    'https://images.unsplash.com/photo-1543466835-00a7907e9de1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=512&q=80';

const _organizationAvatarUrl =
    'https://images.unsplash.com/photo-1599305445671-ac291c95aaa9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=256&q=80';
