String formatCurrency(double number) {
  if (number >= 1000000) {
    // Convert to millions (M)
    double result = number / 1000000;
    return '\$${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
  } else if (number >= 1000) {
    // Convert to thousands (K)
    double result = number / 1000;
    return '\$${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
  } else {
    // Return the number as is
    return '\$${number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 1)}';
  }
}
