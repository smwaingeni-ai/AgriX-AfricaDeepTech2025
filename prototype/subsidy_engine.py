# subsidy_engine.py

import pandas as pd
import os

class SubsidyEngine:
    def __init__(self, csv_path):
        if not os.path.exists(csv_path):
            raise FileNotFoundError(f"Subsidy file not found at: {csv_path}")

        self.df = pd.read_csv(csv_path)

        required_cols = {'AdviceType', 'Cost', 'Currency', 'SubsidyPercent', 'ApplicableTo'}
        if not required_cols.issubset(self.df.columns):
            raise ValueError(f"CSV file must contain columns: {required_cols}")

    def calculate_cost(self, advice_type, applicant_group):
        matches = self.df[self.df['AdviceType'].str.lower() == advice_type.lower()]
        if matches.empty:
            return {"error": f"No advice found for type '{advice_type}'."}

        row = matches.iloc[0]
        cost = float(row['Cost'])
        currency = row['Currency']
        subsidy = float(row['SubsidyPercent'])
        applicable_to = str(row['ApplicableTo'])

        # Check eligibility
        eligible = applicable_to.lower() == "all" or applicant_group.lower() in applicable_to.lower()
        subsidy_applied = subsidy if eligible else 0
        final_cost = cost * (1 - subsidy_applied / 100)

        return {
            "Advice Type": advice_type,
            "Applicant Group": applicant_group,
            "Currency": currency,
            "Base Cost": cost,
            "Eligible for Subsidy": eligible,
            "Subsidy %": subsidy_applied,
            "Final Cost": round(final_cost, 2)
        }

# Optional test block
if __name__ == "__main__":
    test_file = "data/costing/advice_costs.csv"
    try:
        engine = SubsidyEngine(test_file)
        result = engine.calculate_cost("Crop Disease Treatment", "FemaleOnly")

        print("\n💸 Subsidy Calculation Result:")
        for k, v in result.items():
            print(f"{k}: {v}")
    except Exception as e:
        print(f"❌ Error: {e}")
