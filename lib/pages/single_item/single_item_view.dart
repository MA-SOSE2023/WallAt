import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/provider.dart';
import 'model/single_item.dart';

class SingleItemPage extends ConsumerWidget {
  const SingleItemPage({required String id, Key? key})
      : _id = id,
        super(key: key);

  final String _id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SingleItem item =
        ref.watch(Providers.singleItemControllerProvider(_id));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                PictureContainer(
                  id: _id,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InfoContainer(
                    text: item.description,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ActionButtons(),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

class PictureContainer extends ConsumerStatefulWidget {
  const PictureContainer({
    Key? key,
    required String id,
  })  : _id = id,
        super(key: key);

  final String _id;

  @override
  ConsumerState<PictureContainer> createState() => _PictureContainerState();
}

class _PictureContainerState extends ConsumerState<PictureContainer> {
  bool isFullscreen = false;

  @override
  Widget build(BuildContext context) {
    final SingleItemController controller =
        ref.read(Providers.singleItemControllerProvider(widget._id).notifier);
    final double itemImageHeight = MediaQuery.of(context).size.height / 1.5;
    if (isFullscreen) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isFullscreen = false;
          });
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FittedBox(
            fit: BoxFit.contain,
            child: controller.getImage(),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            isFullscreen = true;
          });
        },
        child: Container(
          height: itemImageHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.cover,
            child: controller.getImage(),
          ),
        ),
      );
    }
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 11,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          onPressed: () {},
          icon: Icons.share,
        ),
        _buildActionButton(
          onPressed: () {},
          icon: Icons.edit,
        ),
        _buildActionButton(
          onPressed: () {},
          icon: Icons.delete,
        ),
        _buildActionButton(
          onPressed: () {},
          icon: Icons.favorite,
        ),
      ],
    );
  }

  Widget _buildActionButton(
      {required VoidCallback onPressed, required IconData icon}) {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: Colors.white,
      ),
    );
  }
}

abstract class SingleItemController extends StateNotifier<SingleItem> {
  SingleItemController(SingleItem state) : super(state);

  Image getImage();
  String getDescription();
}
