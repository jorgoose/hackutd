import 'package:finteach/Domain/chapter.dart';
import 'package:flutter/material.dart';

// Personal finance topics that underprivledged students may not know about
List<Chapters> chaptersList = [
  Chapters(name: 'Credit', icon: Icons.credit_score),
  Chapters(name: 'Mortgages', icon: Icons.account_balance),
  Chapters(name: 'Retirement Planning', icon: Icons.savings),
  Chapters(name: 'Investments', icon: Icons.trending_up),
  Chapters(name: 'Real Estate', icon: Icons.business_center),
  Chapters(name: 'Budget Management', icon: Icons.attach_money),
  Chapters(name: 'College Planning', icon: Icons.school),
  Chapters(name: 'Taxes', icon: Icons.paid),
  Chapters(name: 'Insurance', icon: Icons.receipt),
  Chapters(name: 'Banking', icon: Icons.account_balance_wallet),
  Chapters(name: 'Debt', icon: Icons.money_off),
];

var rawData = {
  "questions": [
    {
      "question": "What is a budget?",
      "options": [
        "A plan for making and spending money",
        "A summary of past financial transactions",
        "A record of tax payments",
        "A digital form of currency"
      ],
      "answer": 0
    },
    {
      "question": "What is the primary purpose of insurance?",
      "options": [
        "To invest in the stock market",
        "To protect against potential financial losses",
        "To pay for daily expenses",
        "To loan money to others"
      ],
      "answer": 1
    },
    {
      "question": "Which of the following is considered a liability?",
      "options": [
        "A car loan",
        "A checking account",
        "Investment in stocks",
        "A retirement savings account"
      ],
      "answer": 0
    },
    {
      "question":
          "What does 'interest' mean in the context of a savings account?",
      "options": [
        "The fees charged for maintaining the account",
        "A penalty for withdrawing money",
        "The money paid by the bank to the account holder for keeping money in the account",
        "The money the account holder pays to the bank for account services"
      ],
      "answer": 2
    },
    {
      "question": "What is the benefit of diversifying your investments?",
      "options": [
        "Guaranteed increase in investment value",
        "Reducing risk by spreading investments across various assets",
        "Focusing on a single industry to maximize profits",
        "It is required by the government for tax purposes"
      ],
      "answer": 1
    },
    {
      "question": "What is a credit score?",
      "options": [
        "A numerical representation of your investment knowledge",
        "A score that measures your physical health",
        "A numerical expression based on a level analysis of a person's credit files, to represent the creditworthiness of an individual",
        "A score given to you at the beginning of a video game"
      ],
      "answer": 2
    },
    {
      "question": "What is inflation?",
      "options": [
        "The increase in prices for services and goods over time",
        "The interest rate on a loan",
        "A type of investment strategy",
        "The process of deflating something"
      ],
      "answer": 0
    }
    
  ]
};

/*

    */