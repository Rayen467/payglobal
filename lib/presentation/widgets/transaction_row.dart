import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../domain/entities/transaction_entity.dart';
import 'feature_icon.dart';

class TransactionRow extends StatelessWidget {
  final TransactionEntity txn;
  final bool divider;

  const TransactionRow({super.key, required this.txn, this.divider = false});

  @override
  Widget build(BuildContext context) {
    final isCredit = txn.isCredit;
    return Column(
      children: [
        if (divider) const Divider(height: 1, indent: 16, color: AppColors.line2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              FeatureIcon(
                icon: isCredit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                tone: isCredit ? 'green' : 'red',
                size: 42,
                iconSize: 20,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      txn.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      txn.dateFormatted,
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 12.5,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${isCredit ? '+' : '-'}${CurrencyFormatter.format(txn.amount)}',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: isCredit ? AppColors.green : AppColors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
