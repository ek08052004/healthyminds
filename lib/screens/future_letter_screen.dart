import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class FutureLetterScreen extends StatefulWidget {
  @override
  _FutureLetterScreenState createState() => _FutureLetterScreenState();
}

class _FutureLetterScreenState extends State<FutureLetterScreen> {
  String selectedOption = '1 year'; // Default dropdown value
  String recipientEmail =
      'You'; // Default recipient (email of the logged-in user)
  TextEditingController _controller =
      TextEditingController(text: 'Dear Future Me, ');

  // Methods to apply text styles
  void _applyBold() {
    _applyStyle('**');
  }

  void _applyItalic() {
    _applyStyle('*');
  }

  void _applyBullet() {
    _insertText('- ');
  }

  void _applyStyle(String style) {
    final text = _controller.text;
    final selection = _controller.selection;

    // Extract the selected text
    final selectedText = selection.textInside(text);

    // Surround the selected text with the style markers
    final newText = selection.textBefore(text) +
        '$style$selectedText$style' +
        selection.textAfter(text);

    // Set the new text and adjust the selection
    _controller.value = _controller.value.copyWith(
      text: newText,
      selection: TextSelection(
        baseOffset: selection.baseOffset + style.length,
        extentOffset: selection.extentOffset + style.length,
      ),
    );
  }

  void _insertText(String newText) {
    final text = _controller.text;
    final selection = _controller.selection;

    // Insert the new text at the current selection
    final updatedText =
        selection.textBefore(text) + newText + selection.textAfter(text);

    // Set the new text and adjust the cursor position
    _controller.value = _controller.value.copyWith(
      text: updatedText,
      selection: TextSelection.collapsed(
        offset: selection.baseOffset + newText.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date and format it
    String formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 133, 76, 143), // Darker purple at the top
                Color.fromARGB(
                    255, 192, 147, 200), // Lighter purple towards the bottom
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            title: Text('Write Future Letters'),
            backgroundColor:
                Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Remove AppBar shadow
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A Letter from $formattedDate:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                // Dropdown Box
                Container(
                  width: MediaQuery.of(context).size.width * 0.28,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 183, 127, 193)
                            .withOpacity(0.2), // Slight purple shadow
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: selectedOption,
                    isExpanded: true,
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue!;
                      });
                    },
                    items: <String>['6 months', '1 year', '3 years', '5 years']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 16)),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 16),
                // Recipient Email Box
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enter Email Address',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      recipientEmail = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter email...',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.purple, // Button color
                                  ),
                                  child: Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 201, 145, 210)
                                .withOpacity(0.2), // Slight purple shadow
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              recipientEmail,
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.format_bold),
                  onPressed: _applyBold,
                ),
                IconButton(
                  icon: Icon(Icons.format_italic),
                  onPressed: _applyItalic,
                ),
                IconButton(
                  icon: Icon(Icons.format_list_bulleted),
                  onPressed: _applyBullet,
                ),
              ],
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Write your letter here...',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle saving or submitting the letter
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 192, 147, 200), // Button color
              ),
              child: Text(
                'Send Letter',
                style:
                    TextStyle(color: Colors.white), // Text color set to white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
