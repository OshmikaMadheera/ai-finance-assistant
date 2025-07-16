import random;
import datetime;
import from mtllm.llm { Model }

glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

# AI-powered functions for financial insights
def analyze_spending_pattern(transactions: list, categories: list) -> str by llm();
def generate_budget_advice(income: float, expenses: float, savings_goal: float) -> str by llm();
def predict_savings_timeline(current_savings: float, monthly_savings: float, goal: float) -> str by llm();
def suggest_investment_strategy(age: int, risk_tolerance: str, savings: float) -> str by llm();
def detect_unusual_spending(recent_transactions: list, average_spending: float) -> str by llm();

walker FinanceAssistant {
    has user_name: str;
    has monthly_income: float;
    has savings_goal: float;
    has current_savings: float;
    has age: int;
    has risk_tolerance: str;

    can initialize_user with `root entry;
    can add_transaction with user_profile entry;
    can analyze_finances with user_profile entry;
    can get_budget_advice with user_profile entry;
    can predict_goals with user_profile entry;
    can investment_guidance with user_profile entry;
    can spending_alert with user_profile entry;
}

node user_profile {
    has name: str;
    has monthly_income: float;
    has savings_goal: float;
    has current_savings: float;
    has age: int;
    has risk_tolerance: str;
    has total_expenses: float;
    has transaction_count: int;
    has created_at: str;
}

node transaction {
    has amount: float;
    has category: str;
    has description: str;
    has date: str;
    has transaction_type: str; # "expense" or "income"
}

node analysis_result {
    has analysis_type: str;
    has insights: str;
    has recommendations: str;
    has created_at: str;
}

node budget_plan {
    has recommended_budget: dict;
    has savings_plan: str;
    has timeline_prediction: str;
    has created_at: str;
}

with entry:__main__ {
    print("AI-Powered Personal Finance Assistant");
    print("==================================================");
    
    # Demo user scenarios
    print("\nDemo 1: College Student Financial Planning");
    root spawn FinanceAssistant(
        user_name="Alice",
        monthly_income=800.0,
        savings_goal=5000.0,
        current_savings=150.0,
        age=20,
        risk_tolerance="low"
    );
    
    print("\nDemo 2: Young Professional Investment Planning");
    root spawn FinanceAssistant(
        user_name="Bob",
        monthly_income=4500.0,
        savings_goal=50000.0,
        current_savings=8000.0,
        age=28,
        risk_tolerance="moderate"
    );
    
    print("\nDemo 3: Mid-Career Retirement Planning");
    root spawn FinanceAssistant(
        user_name="Carol",
        monthly_income=7200.0,
        savings_goal=100000.0,
        current_savings=25000.0,
        age=35,
        risk_tolerance="aggressive"
    );
}
