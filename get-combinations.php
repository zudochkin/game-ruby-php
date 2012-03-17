<?php 
$paths = array();
/**
* рекурсивный поиск в глубину
*
* @param $graph array наш граф
* @param $start string точка "откуда"
* @param $end string точка "куда"
* @param $path array массив предыдущих шагов
**/
function find_path($graph, $start, $end, $path = array())
{
  global $paths;
  $path[] = $start;
  
  if ($start == $end)
     return $path;
  
  if (!isset($graph[$start]))
     return false;

  # находим всех соседей
  foreach($graph[$start] as $node) {
    if (!in_array($node, $path)) {
      $newpath = find_path($graph, $node, $end, $path);
      if ($newpath) 
        $paths[] = implode(',', $newpath);
    }
  }
  return array();
}

# получившийся граф
$graph = array(
  '1' => array('2', '4', '5'),
  '2' => array('1', '3', '5', '4', '6'),
  '3' => array('2', '5', '6'),
  '4' => array('1', '2', '7', '8', '5'),
  '5' => array('1', '2', '3', '4', '6', '7', '8'),
  '6' => array('3', '2', '5', '9', '8'),
  '7' => array('4', '5', '8'),
  '8' => array('4', '6', '6', '7', '9'),
  '9' => array('5', '6', '8')
);

# циклы по всем вершинам графа,
# каждая вершина может быть начальной и конечной
for($i = 1; $i <= 9; $i++)  
  for($j = 1; $j <= 9; $j++)
    find_path($graph, (string) $i, (string) $j);

# избавляемся от дубликатов
$result = array_unique($paths);
echo "\n\nКоличество комбинаций: ", count($result), "\n";

# записываем результаты в файл
$fh = fopen('combinations.dat', 'a');
 fwrite($fh, implode("\n", $result));
fclose($fh);