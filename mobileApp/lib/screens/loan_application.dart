import 'package:flutter/material.dart';
import '../models/farmer_profile.dart';
import '../services/farmer_service.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({super.key});
  @override _LoanApplicationScreenState createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  FarmerProfile? _selected;
  final _amountCtr = TextEditingController();
  final Map<String, FarmerProfile> _all = {};

  @override void initState(){
    super.initState();
    FarmerService.loadFarmers().then((f){
      setState(() => f.forEach((x)=>_all[x.id]=x));
    });
  }

  double _score(FarmerProfile f){
    // crude scoring example
    double score = f.farmSizeHectares * (f.govtAffiliated? 1.5:1.0);
    return score.clamp(0,100);
  }

  void _submit(){
    if (_selected==null || double.tryParse(_amountCtr.text)==null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select farmer & amount')));
      return;
    }
    final s = _score(_selected!);
    final approved = s > 30; // threshold
    showDialog(context: context, builder:(_)=>
      AlertDialog(
        title: const Text('Loan status'),
        content: Text(approved
          ? '✅ Approved (Score: ${s.toStringAsFixed(1)})'
          : '❌ Not approved (Score: ${s.toStringAsFixed(1)})'
        ),
        actions: [ TextButton(onPressed:(){Navigator.pop(context);}, child:const Text('OK'))],
      ));
  }

  @override Widget build(BuildContext c)=>Scaffold(
    appBar: AppBar(title:const Text('Apply for Loan')),
    body: Padding(padding: const EdgeInsets.all(16),child:
      Column(
        children:[
          DropdownButtonFormField<FarmerProfile?>(
            items:[
              ..._all.values.map((f)=>DropdownMenuItem(
                value:f,child:Text(f.name+' (${f.govtAffiliated?'Govt':'Non'})'))),
            ],
            onChanged:(v)=>setState(()=>_selected=v),
            hint:const Text('Select Farmer'),
          ),
          const SizedBox(height:10),
          TextFormField(
            controller: _amountCtr,
            decoration:const InputDecoration(labelText:'Loan Amount'),
            keyboardType:TextInputType.number,
          ),
          const SizedBox(height:20),
          ElevatedButton(onPressed:_submit,child:const Text('Submit')),
        ],
      )),
  );
}
