/**
 * @description Find all functions that have more than 10 lines
 * @kind problem
 * @id javascript/functions-longer-than-ten-lines
 * @problem.severity recommendation
 */
import javascript

/**
 * Holds if a function has more than 10 lines
 */

predicate hasMoreThanTenLines(Function func) {
  exists(DataFlow::CallNode call |
    call.getEnclosingFunction() = func and
    call.getNumLines() > 10
  )
}

from Function func
where hasMoreThanTenLines(func)
select func, "has more than 10 lines"