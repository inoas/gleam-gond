import gleam/list

/// Represents a condition that can be evaluated lazily or eagerly,
/// or a mere fact where the consequence is already known.
///
pub opaque type Branch(a) {
  Branch(condition: Condition, consequence: Consequence(a))
}

pub opaque type Condition {
  // AndCondition
  // OrCondition
  // XorCondition
  // NorCondition
  LazyCondition(condition_fun: fn() -> Bool)
  EagerCondition(condition: Bool)
}

pub opaque type Consequence(a) {
  LazyConsequence(consequence_fun: fn() -> a)
  EagerConsequence(consequence: a)
}

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

pub fn when(given condition_fun: fn() -> Bool) -> Condition {
  LazyCondition(condition_fun:)
}

pub fn where(given condition: Bool) -> Condition {
  EagerCondition(condition:)
}

pub fn run(
  on condition: Condition,
  consequence consequence_fun: fn() -> a,
) -> Branch(a) {
  Branch(condition:, consequence: LazyConsequence(consequence_fun))
}

pub fn return(on condition: Condition, consequence consequence: a) -> Branch(a) {
  Branch(condition:, consequence: EagerConsequence(consequence))
}
