//// 🔠 Multi-branch conditional expressions for Gleam
////

import gleam/list

/// Represents a branch of a conditional expressions.
///
pub opaque type Branch(a) {
  Branch(condition: Condition, consequence: Consequence(a))
}

/// Represents a condition that can be evaluated lazily or eagerly,
///
pub opaque type Condition {
  // AndCondition
  // OrCondition
  // XorCondition
  // NorCondition
  LazyCondition(condition_fun: fn() -> Bool)
  EagerCondition(condition: Bool)
}

/// Represents a condition that can be evaluated lazily or eagerly,
///
pub opaque type Consequence(a) {
  LazyConsequence(consequence_fun: fn() -> a)
  EagerConsequence(consequence: a)
}

/// Executes a list of branches and returns the consequence of the first branch
/// that evaluates to true.
///
/// If no branch evaluates to true, the default alternative function is executed.
///
pub fn cond(
  branches branches: List(Branch(a)),
  default alternative_fun: fn() -> a,
) -> a {
  list.fold_until(
    over: branches,
    from: alternative_fun,
    with: fn(acc, branch: Branch(a)) {
      let condition_evaluation = case branch.condition {
        LazyCondition(condition_fun) -> condition_fun()
        EagerCondition(condition) -> condition
      }
      case condition_evaluation {
        True ->
          case branch.consequence {
            LazyConsequence(consequence_fun) -> list.Stop(consequence_fun)
            EagerConsequence(consequence) -> list.Stop(fn() { consequence })
          }
        False -> list.Continue(acc)
      }
    },
  )()
}

/// Creates a condition that evaluates to true if the given function returns
/// true.
///
pub fn when(given condition_fun: fn() -> Bool) -> Condition {
  LazyCondition(condition_fun:)
}

/// Creates a condition that holds a literal boolean value.
///
pub fn fact(given condition: Bool) -> Condition {
  EagerCondition(condition:)
}

/// Consequence to run if a previous condition evaluates to true.
///
pub fn run(
  on condition: Condition,
  consequence consequence_fun: fn() -> a,
) -> Branch(a) {
  Branch(condition:, consequence: LazyConsequence(consequence_fun))
}

/// Literal consequence to yield if a previous condition evaluates to
/// true.
///
pub fn yield(on condition: Condition, consequence consequence: a) -> Branch(a) {
  Branch(condition:, consequence: EagerConsequence(consequence))
}
