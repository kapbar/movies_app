import 'package:flutter/material.dart';

class ScreenCastWidget extends StatelessWidget {
  const ScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Series Cast',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 380,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: 20,
                itemExtent: 140,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            const Placeholder(
                              fallbackWidth: 140,
                              fallbackHeight: 160,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Steven Yuen',
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    'Steven Yuen const BorderRadius scrollDirection: Axis.horizontal',
                                    maxLines: 4,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '8 Episodes',
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('Full Cast & Crew'),
            ),
          ),
        ],
      ),
    );
  }
}
