import 'package:flutter/material.dart';

void main() => runApp(DearZindagiApp());

class DearZindagiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LoginScreen(),
    );
  }
}

// Login Page
class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Dear Zindagi', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Survey Screen after login (skipping login logic for now)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveyScreen()),
                );
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Registration Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
              child: Text('Don’t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}

// Registration Page
class RegistrationScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dear Zindagi - Register',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Survey Screen after registration
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveyScreen()),
                );
              },
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Go back to login screen
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// Survey Page
class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final List<String> questions = [
    "How many hours do you sleep?",
    "How often do you feel stressed?",
    "Do you experience mood swings frequently?",
    "How often do you exercise in a week?",
    "Do you feel mentally exhausted most of the time?",
    "How often do you feel anxious?",
    "Do you have trouble focusing or concentrating?",
    "How often do you take breaks throughout the day?",
    "Do you feel isolated or lonely?",
    "Do you have a support system (friends/family)?"
  ];

  final List<List<String>> options = [
    ["<5", "6", "7", "8", ">8"],
    ["Rarely", "Sometimes", "Often", "Always"],
    ["Never", "Occasionally", "Frequently", "Always"],
    ["Never", "1-2 times", "3-4 times", "5+ times"],
    ["Never", "Sometimes", "Often", "Always"],
    ["Rarely", "Sometimes", "Often", "Always"],
    ["Never", "Occasionally", "Frequently", "Always"],
    ["Rarely", "Sometimes", "Often", "Always"],
    ["Rarely", "Sometimes", "Often", "Always"],
    ["Yes", "No"]
  ];

  final List<int> _answers = List.filled(10, -1);

  void _submitSurvey() {
    int score = 0;
    // Assign points based on answers
    for (int i = 0; i < _answers.length; i++) {
      score += _answers[i] == -1 ? 0 : _answers[i];
    }
    String result;
    if (score <= 15) {
      result =
          "Your mental health is in poor condition. Please consult a doctor.";
    } else if (score <= 25) {
      result =
          "Your mental health could improve. Consider speaking with a therapist.";
    } else {
      result = "You're doing great! Keep maintaining your mental health.";
    }

    // Navigate to result screen
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SurveyResultScreen(result: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mental Health Survey',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Q${index + 1}: ${questions[index]}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ...List.generate(options[index].length, (optionIndex) {
                        return RadioListTile<int>(
                          title: Text(options[index][optionIndex]),
                          value: optionIndex,
                          groupValue: _answers[index],
                          onChanged: (value) {
                            setState(() {
                              _answers[index] = value!;
                            });
                          },
                        );
                      }),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _submitSurvey,
              child: Text('Submit Survey'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Survey Result Screen
class SurveyResultScreen extends StatelessWidget {
  final String result;

  SurveyResultScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    // Dummy therapist data
    final List<Map<String, String>> therapists = [
      {
        "name": "Dr. Priya Sharma",
        "specialization": "Clinical Psychologist",
        "contact": "+91 9876543210",
        "location": "Mind Wellness Clinic, Lucknow"
      },
      {
        "name": "Dr. Arjun Mehta",
        "specialization": "Counseling Psychologist",
        "contact": "+91 8765432109",
        "location": "Happiness Center, Lucknow"
      },
      {
        "name": "Dr. Kavita Verma",
        "specialization": "Psychiatrist",
        "contact": "+91 7654321098",
        "location": "Hope Care Hospital, Lucknow"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Results',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            if (result.contains("consult a doctor") ||
                result.contains("could improve"))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Here are some therapists nearby:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: therapists.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(therapists[index]["name"]!),
                          subtitle: Text(
                              "${therapists[index]["specialization"]} \n${therapists[index]["contact"]} \n${therapists[index]["location"]}"),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
