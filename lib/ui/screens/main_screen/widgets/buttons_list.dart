part of '../main_screen.dart';

class ButtonsList extends StatelessWidget {
  final List<Button> buttons;

  const ButtonsList({
    Key? key,
    required this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottom = 30;
    double top = 30;

    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        if (index == 0) top = 0;

        return InkWell(
          onTap: () => print(buttons[index].action),
          child: Container(
            alignment: Alignment.topLeft,
            height: 150,
            margin: EdgeInsets.only(top: top, right: 16, left: 16, bottom: bottom),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffB9B9B9), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Color(0xFFB2DF28),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            buttons[index].action,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
