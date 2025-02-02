import 'dart:io';

void main() async {
  
  String filePath = 'C:\\Users\\Taha Majeed\\Desktop\\SMD Dart Program\\sample text.txt';

  try {
    List<String> lines = await File(filePath).readAsLines();
    Map<int, List<String>> lineWordFrequencies = {};
    int maxFrequency = 0;
    List<int> maxFrequencyLines = [];

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i].toLowerCase();
      List<String> words = line.split(RegExp(r'\W+')).where((w) => w.isNotEmpty).toList();
      
      if (words.isEmpty) continue;
      
      Map<String, int> frequencyMap = {};
      for (var word in words) {
        frequencyMap[word] = (frequencyMap[word] ?? 0) + 1;
      }

      int highestFrequency = frequencyMap.values.reduce((a, b) => a > b ? a : b);
      List<String> highestWords = frequencyMap.entries
          .where((entry) => entry.value == highestFrequency)
          .map((entry) => entry.key)
          .toList();

      lineWordFrequencies[i + 1] = highestWords;
      
      if (highestFrequency > maxFrequency) {
        maxFrequency = highestFrequency;
        maxFrequencyLines = [i + 1];
      } else if (highestFrequency == maxFrequency) {
        maxFrequencyLines.add(i + 1);
      }
    }

    print("The following words have the highest word frequency per line:");
    lineWordFrequencies.forEach((line, words) {
      print("$words (appears in line #$line)");
    });

    print("\nLines with the highest occurring word frequency:");
    print(maxFrequencyLines);
  } catch (e) {
    print("Error reading the file: $e");
  }
}