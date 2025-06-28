# subsidy_engine.py

import pandas as pd

class SubsidyEngine:
    def __init__(self, csv_path):
        self.df = pd.read_csv(csv_path)

    def calculate_cost(self, advice_type, applicant_group):
        try:
            row = self.df[self.df['AdviceType'] == advice_type].iloc[0]
            cost = row['Cost']
            currency = row['Currency']
            subsidy = row['SubsidyPercent']
            applicable_to = row['ApplicableTo']

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

        except IndexError:
            return {"error": f"No advice found for type '{advice_type}'."}

# Optional test block
if __name__ == "__main__":
    engine = SubsidyEngine("data/costing/advice_costs.csv")

    # Try changing values below
    result = engine.calculate_cost("Crop Disease Treatment", "FemaleOnly")

    print("\n💸 Subsidy Calculation Result:")
    for k, v in result.items():
        print(f"{k}: {v}")
