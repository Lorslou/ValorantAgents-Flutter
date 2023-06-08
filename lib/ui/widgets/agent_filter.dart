import 'package:flutter/material.dart';

class AgentFilter extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String> onRoleSelected;

  const AgentFilter({
    Key? key,
    required this.selectedRole,
    required this.onRoleSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilterButton(
          role: "Controller",
          isSelected: selectedRole == "Controller",
          onPressed: onRoleSelected,
        ),
        FilterButton(
          role: "Duelist",
          isSelected: selectedRole == "Duelist",
          onPressed: onRoleSelected,
        ),
        FilterButton(
          role: "Initiator",
          isSelected: selectedRole == "Initiator",
          onPressed: onRoleSelected,
        ),
        FilterButton(
          role: "Sentinel",
          isSelected: selectedRole == "Sentinel",
          onPressed: onRoleSelected,
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final String role;
  final bool isSelected;
  final Function(String) onPressed;

  const FilterButton({
    Key? key,
    required this.role,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(role),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isSelected ? Colors.blue : Colors.grey,
        ),
      ),
      child: Text(
        role,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
