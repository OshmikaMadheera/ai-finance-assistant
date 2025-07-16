import math;
import datetime;
import random;

impl FinanceAssistant.initialize_user {
    print(f"Welcome {self.user_name}! Setting up your financial profile...");
    
    # Check if user profile already exists
    profile_node = [root --> (`?user_profile)];
    
    if not profile_node {
        # Create new user profile
        profile_node = root ++> user_profile(
            name=self.user_name,
            monthly_income=self.monthly_income,
            savings_goal=self.savings_goal,
            current_savings=self.current_savings,
            age=self.age,
            risk_tolerance=self.risk_tolerance,
            total_expenses=0.0,
            transaction_count=0,
            created_at=str(datetime.datetime.now())
        );
        
        print(f"Profile created for {self.user_name}");
        print(f"Monthly Income: ${self.monthly_income:,.2f}");
        print(f"Savings Goal: ${self.savings_goal:,.2f}");
        print(f"Current Savings: ${self.current_savings:,.2f}");
        print(f"Risk Tolerance: {self.risk_tolerance}");
        
        # Add some sample transactions for demonstration
        self.add_sample_transactions(profile_node);
    }
    
    visit profile_node;
}

impl FinanceAssistant.add_transaction {
    print(f"Adding transactions for {here.name}...");
    
    # Sample transaction data based on user profile
    sample_transactions = self.get_sample_transactions(here.monthly_income);
    
    total_expenses = 0.0;
    transaction_count = 0;
    
    for transaction_data in sample_transactions {
        transaction_node = here ++> transaction(
            amount=transaction_data["amount"],
            category=transaction_data["category"],
            description=transaction_data["description"],
            date=transaction_data["date"],
            transaction_type=transaction_data["type"]
        );
        
        if transaction_data["type"] == "expense" {
            total_expenses += transaction_data["amount"];
        }
        transaction_count += 1;
    }
    
    here.total_expenses = total_expenses;
    here.transaction_count = transaction_count;
    
    print(f"Added {transaction_count} transactions");
    print(f"Total Expenses: ${total_expenses:,.2f}");
    
    # Continue to analysis
    visit here with analyze_finances;
}

impl FinanceAssistant.analyze_finances {
    print(f"\nAnalyzing {here.name}'s spending patterns...");
    
    # Get all transactions
    transactions = [here --> (`?transaction)];
    
    # Prepare data for AI analysis
    transaction_data = [];
    categories = [];
    
    for trans in transactions {
        transaction_data.append({
            "amount": trans.amount,
            "category": trans.category,
            "description": trans.description,
            "type": trans.transaction_type
        });
        
        if trans.category not in categories {
            categories.append(trans.category);
        }
    }
    
    # Get AI analysis
    spending_analysis = analyze_spending_pattern(transaction_data, categories);
    
    # Create analysis result node
    analysis_node = here ++> analysis_result(
        analysis_type="spending_pattern",
        insights=spending_analysis,
        recommendations="",
        created_at=str(datetime.datetime.now())
    );
    
    print(f"AI Analysis: {spending_analysis}");
    
    # Continue to budget advice
    visit here with get_budget_advice;
}

impl FinanceAssistant.get_budget_advice {
    print(f"\nGenerating budget advice for {here.name}...");
    
    # Calculate financial metrics
    net_income = here.monthly_income - here.total_expenses;
    savings_rate = (net_income / here.monthly_income) * 100 if here.monthly_income > 0 else 0;
    
    print(f"Financial Summary:");
    print(f"   Monthly Income: ${here.monthly_income:,.2f}");
    print(f"   Monthly Expenses: ${here.total_expenses:,.2f}");
    print(f"   Net Income: ${net_income:,.2f}");
    print(f"   Savings Rate: {savings_rate:.1f}%");
    
    # Get AI-generated budget advice
    budget_advice = generate_budget_advice(
        here.monthly_income,
        here.total_expenses,
        here.savings_goal
    );
    
    # Create budget plan
    recommended_budget = {
        "housing": here.monthly_income * 0.30,
        "food": here.monthly_income * 0.15,
        "transportation": here.monthly_income * 0.15,
        "utilities": here.monthly_income * 0.10,
        "savings": here.monthly_income * 0.20,
        "entertainment": here.monthly_income * 0.10
    };
    
    budget_node = here ++> budget_plan(
        recommended_budget=recommended_budget,
        savings_plan=budget_advice,
        timeline_prediction="",
        created_at=str(datetime.datetime.now())
    );
    
    print(f"AI Budget Advice: {budget_advice}");
    
    # Continue to goal prediction
    visit here with predict_goals;
}

impl FinanceAssistant.predict_goals {
    print(f"\nPredicting savings timeline for {here.name}...");
    
    # Calculate monthly savings potential
    monthly_savings = here.monthly_income - here.total_expenses;
    
    if monthly_savings <= 0 {
        print("Warning: Current expenses exceed income!");
        monthly_savings = here.monthly_income * 0.10; # Assume 10% savings target
    }
    
    # Get AI prediction
    timeline_prediction = predict_savings_timeline(
        here.current_savings,
        monthly_savings,
        here.savings_goal
    );
    
    # Update budget plan with timeline
    budget_node = [here --> (`?budget_plan)];
    if budget_node {
        budget_node.timeline_prediction = timeline_prediction;
    }
    
    # Calculate time to goal
    remaining_amount = here.savings_goal - here.current_savings;
    months_to_goal = math.ceil(remaining_amount / monthly_savings) if monthly_savings > 0 else float('inf');
    
    print(f"Savings Projection:");
    print(f"   Monthly Savings: ${monthly_savings:,.2f}");
    print(f"   Months to Goal: {months_to_goal if months_to_goal != float('inf') else 'Not achievable with current spending'}");
    print(f"AI Timeline Prediction: {timeline_prediction}");
    
    # Continue to investment guidance
    visit here with investment_guidance;
}

impl FinanceAssistant.investment_guidance {
    print(f"\nInvestment guidance for {here.name}...");
    
    # Get AI investment suggestions
    investment_advice = suggest_investment_strategy(
        here.age,
        here.risk_tolerance,
        here.current_savings
    );
    
    print(f"AI Investment Strategy: {investment_advice}");
    
    # Continue to spending alerts
    visit here with spending_alert;
}

impl FinanceAssistant.spending_alert {
    print(f"\nChecking for unusual spending patterns for {here.name}...");
    
    # Get recent transactions
    transactions = [here --> (`?transaction)];
    recent_transactions = [];
    
    for trans in transactions {
        if trans.transaction_type == "expense" {
            recent_transactions.append({
                "amount": trans.amount,
                "category": trans.category,
                "description": trans.description
            });
        }
    }
    
    # Calculate average spending
    average_spending = here.total_expenses / here.transaction_count if here.transaction_count > 0 else 0;
    
    # Get AI analysis for unusual spending
    spending_alert = detect_unusual_spending(recent_transactions, average_spending);
    
    print(f"AI Spending Alert: {spending_alert}");
    
    print(f"\nFinancial analysis complete for {here.name}!");
    print("==================================================");
    
    disengage;
}

# Helper methods
def get_sample_transactions(monthly_income: float) -> list {
    # Generate realistic sample transactions based on income level
    base_transactions = [
        {"amount": monthly_income * 0.25, "category": "Housing", "description": "Monthly rent", "type": "expense"},
        {"amount": monthly_income * 0.12, "category": "Food", "description": "Groceries", "type": "expense"},
        {"amount": monthly_income * 0.08, "category": "Transportation", "description": "Gas and car maintenance", "type": "expense"},
        {"amount": monthly_income * 0.05, "category": "Utilities", "description": "Electricity and water", "type": "expense"},
        {"amount": monthly_income * 0.03, "category": "Entertainment", "description": "Movies and dining out", "type": "expense"},
        {"amount": monthly_income * 0.02, "category": "Shopping", "description": "Clothing and personal items", "type": "expense"},
        {"amount": monthly_income * 0.15, "category": "Savings", "description": "Emergency fund contribution", "type": "expense"}
    ];
    
    # Add some variation
    for transaction in base_transactions {
        variation = random.uniform(0.8, 1.2);
        transaction["amount"] = transaction["amount"] * variation;
        transaction["date"] = str(datetime.datetime.now() - datetime.timedelta(days=random.randint(1, 30)));
    }
    
    return base_transactions;
}

def add_sample_transactions(profile_node) {
    # This method would be called from initialize_user
    # Implementation details would go here
    pass;
}
