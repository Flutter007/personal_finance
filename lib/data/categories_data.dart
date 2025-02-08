import 'package:cw26/models/transaction_category.dart';
import 'package:flutter/material.dart';

final categories = [
  TransactionCategory(
    id: 'food_and_drinks',
    title: 'Food and Drinks',
    icon: Icons.restaurant,
  ),
  TransactionCategory(
    id: 'entertainment',
    title: 'Entertainment',
    icon: Icons.theater_comedy_outlined,
  ),
  TransactionCategory(
    id: 'transport',
    title: 'Transport',
    icon: Icons.commute,
  ),
  TransactionCategory(
    id: 'home',
    title: 'Home',
    icon: Icons.home,
  )
];
