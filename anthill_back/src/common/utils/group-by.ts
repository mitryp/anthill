export function groupBy<E>(arr: E[], by: (_: E) => string): { [key: string]: E[] } {
  return arr.reduce((resMap, elem) => {
    const key = by(elem);
    (resMap[key] = resMap[elem[key]] || []).push(elem);
    return resMap;
  }, {});
}
