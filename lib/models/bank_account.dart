class BankAccount {
    final String holderName;
    late String accountNumber;
    double balance;
    String? bankBranch;

    BankAccount({required this.holderName, this.balance = 0.0, this.bankBranch});

    void initializeAccount(String nr) {
      accountNumber = nr;
    }

    bool isAccountSet() {
      try {
        accountNumber.toString();
        return true;
      } catch (e) {
        return false;
      }
    }

    String getAccountDisplay() {
      return isAccountSet() == true ? 'Account: $accountNumber' : 'Uninitialized account message';
    }
}