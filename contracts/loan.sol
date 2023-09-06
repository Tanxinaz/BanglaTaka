// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./storage.sol"; 
import "./scripts/storage.js";

contract BanglaTakaMicroloan {
    BanglaTakaStorage public banglaTakaStorage; 

    struct Loan {
        address borrower;
        uint256 amount;
        uint256 interestRate; // Annual interest rate (in percent)
        uint256 dueDate; // Unix timestamp of the due date
        bool repaid;
    }
    Loan[] public loans;
    uint256 public nextLoanId;

    constructor(address _storageAddress) {
        banglaTakaStorage = BanglaTakaStorage(_storageAddress);
        nextLoanId = 1;
    }

    // Function to request a microloan
    function requestMicroloan(uint256 _amount, uint256 _interestRate, uint256 _dueDate) external {
        require(_amount > 0, "Loan amount must be greater than 0");
        require(_interestRate > 0, "Interest rate must be greater than 0");
        require(_dueDate > block.timestamp, "Due date must be in the future");

        // Ensure the borrower has sufficient collateral in BanglaTaka tokens
        require(banglaTakaStorage.balanceOf(msg.sender) >= _amount, "Insufficient collateral");

        // Transfer the loan amount to the borrower
        banglaTakaStorage.transfer(msg.sender, address(this), _amount);

        // Create a new loan
        Loan memory newLoan = Loan({
            borrower: msg.sender,
            amount: _amount,
            interestRate: _interestRate,
            dueDate: _dueDate,
            repaid: false
        });

        loans.push(newLoan);
        nextLoanId++;

        // Emit an event for the new loan
        emit MicroloanRequested(msg.sender, nextLoanId - 1, _amount);
    }

    // Function to repay a microloan
    function repayMicroloan(uint256 _loanId) external {
        require(_loanId < nextLoanId, "Invalid loan ID");

        Loan storage loan = loans[_loanId];
        require(msg.sender == loan.borrower, "Only the borrower can repay the loan");
        require(!loan.repaid, "Loan is already repaid");
        require(block.timestamp <= loan.dueDate, "Loan is overdue");

        uint256 repaymentAmount = calculateRepaymentAmount(loan.amount, loan.interestRate);

        // Transfer the repayment amount from the borrower to the contract
        banglaTakaStorage.transfer(msg.sender, address(this), repaymentAmount);

        // Transfer the collateral back to the borrower
        banglaTakaStorage.transfer(address(this), msg.sender, loan.amount);

        loan.repaid = true;

        // Emit an event for the loan repayment
        emit MicroloanRepaid(msg.sender, _loanId, repaymentAmount);
    }

    // Calculate the repayment amount including interest
    function calculateRepaymentAmount(uint256 _loanAmount, uint256 _interestRate) internal pure returns (uint256) {
        // Simple interest calculation: Principal + (Principal * InterestRate / 100)
        return _loanAmount + (_loanAmount * _interestRate / 100);
    }

    // Events
    event MicroloanRequested(address indexed borrower, uint256 loanId, uint256 amount);
    event MicroloanRepaid(address indexed borrower, uint256 loanId, uint256 amount);
}
