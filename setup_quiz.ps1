# PowerShell script to set up the Java Quiz Project

# Set the project path
$projectPath = "C:\Users\satya\Techplement\week1-tasks\src"

# Ensure directories exist
New-Item -ItemType Directory -Path "$projectPath\models" -Force
New-Item -ItemType Directory -Path "$projectPath\services" -Force
New-Item -ItemType Directory -Path "$projectPath\utils" -Force

# Create Java model class files
Set-Content -Path "$projectPath\models\Question.java" -Value @"
package models;
import java.util.List;

public class Question {
    private String questionText;
    private List<String> options;
    private int correctOption;

    public Question(String questionText, List<String> options, int correctOption) {
        this.questionText = questionText;
        this.options = options;
        this.correctOption = correctOption;
    }

    public String getQuestionText() { return questionText; }
    public List<String> getOptions() { return options; }
    public int getCorrectOption() { return correctOption; }
}
"@

Set-Content -Path "$projectPath\models\Quiz.java" -Value @"
package models;
import java.util.List;

public class Quiz {
    private String title;
    private List<Question> questions;

    public Quiz(String title, List<Question> questions) {
        this.title = title;
        this.questions = questions;
    }

    public String getTitle() { return title; }
    public List<Question> getQuestions() { return questions; }
}
"@

# Create QuizService class
Set-Content -Path "$projectPath\services\QuizService.java" -Value @"
package services;
import models.Question;
import models.Quiz;
import java.util.*;

public class QuizService {
    private List<Quiz> quizzes = new ArrayList<>();

    public void addQuiz(Quiz quiz) {
        quizzes.add(quiz);
    }

    public void takeQuiz(Quiz quiz) {
        Scanner scanner = new Scanner(System.in);
        int score = 0;

        for (Question q : quiz.getQuestions()) {
            System.out.println(q.getQuestionText());
            List<String> options = q.getOptions();
            for (int i = 0; i < options.size(); i++) {
                System.out.println((i + 1) + ". " + options.get(i));
            }
            System.out.print("Your answer: ");
            int answer = scanner.nextInt();
            if (answer == q.getCorrectOption()) {
                score++;
            }
        }
        System.out.println("Your score: " + score + "/" + quiz.getQuestions().size());
    }
}
"@

# Create InputUtil class
Set-Content -Path "$projectPath\utils\InputUtil.java" -Value @"
package utils;
import java.util.Scanner;

public class InputUtil {
    private static final Scanner scanner = new Scanner(System.in);

    public static String getStringInput(String prompt) {
        System.out.print(prompt);
        return scanner.nextLine();
    }

    public static int getIntInput(String prompt) {
        System.out.print(prompt);
        return scanner.nextInt();
    }
}
"@

# Create the main Java file
Set-Content -Path "$projectPath\Main.java" -Value @"
import models.*;
import services.QuizService;
import java.util.*;

public class Main {
    public static void main(String[] args) {
        QuizService quizService = new QuizService();
        List<Question> questions = new ArrayList<>();

        questions.add(new Question("What is the capital of France?", Arrays.asList("Berlin", "Paris", "Madrid", "Rome"), 2));
        questions.add(new Question("Which planet is known as the Red Planet?", Arrays.asList("Earth", "Mars", "Jupiter", "Venus"), 2));

        Quiz quiz = new Quiz("General Knowledge", questions);
        quizService.addQuiz(quiz);
        quizService.takeQuiz(quiz);
    }
}
"@

# Print success message
Write-Host "All Java files have been created successfully! You can now compile and run your project." -ForegroundColor Green
