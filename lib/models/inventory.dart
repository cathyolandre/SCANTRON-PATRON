// lib/models/inventory.dart

class Inventory {
  int paperLimit;

  Inventory(this.paperLimit);
  
  void deductPaper(int amount) {
    if (amount <= paperLimit) {
      paperLimit -= amount;
    }
  }
}
