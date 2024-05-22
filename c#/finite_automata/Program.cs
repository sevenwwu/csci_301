

public class Program
{

    public static void Main()
    {

        HashSet<HashSet<int>> sets = [];

        sets.Add([1,2,3]);
        sets.Add([1,2,3]);

        // HashSet<int> set = [1,2,3];

        // HashSet<HashSet<int>> powerSet = FiniteAutomaton<int>.PowerSet(set);


        // foreach (var subset in powerSet)
        // {
        //     Console.Write("[");
        //     foreach (var num in subset)
        //     {
        //         Console.Write(num + ",");
        //     }
        //     Console.WriteLine("]");
        // }
 

        // List<string> strings = [
        //     "",
        //     "1111110100100",
        //     "000000001010000111",
        //     "001010",
        //     "001000010",
        //     "0001010",
        //     "110111111100",
        //     "11000011101111111",
        //     "10101"
        // ];

        // foreach (var str in strings)
        // {
        //     Console.WriteLine($"{str}: {threeOnesInARow.Accepts(str)}");
        // }

        // Console.WriteLine("------------------------------");

        // foreach (var str in strings)
        // {
        //     Console.WriteLine($"{str}: {evenNumOnes.Accepts(str)}");
        // }

        // Console.WriteLine("------------------------------");

        // var union = FiniteAutomaton<(int,int)>.Union<int,int>(threeOnesInARow,evenNumOnes);
        // foreach(var str in strings)
        // {
        //     Console.WriteLine($"{str}: {union.Accepts(str)}");
        // }
    }


    //    var threeOnesInARow = new FiniteAutomaton<int>
    //     (
    //         [0,1,2,3],
    //         ['0','1'],
    //         new Dictionary<(int, char), int>{
    //             {(0,'0'),0},
    //             {(0,'1'),1},
    //             {(1,'0'),0},
    //             {(1,'1'),2},
    //             {(2,'0'),0},
    //             {(2,'1'),3},
    //             {(3,'0'),3},
    //             {(3,'1'),3}
    //         },
    //         0,
    //         [3]
    //     );

    //     var evenNumOnes = new FiniteAutomaton<int>
    //     (
    //         [0,1],
    //         ['0','1'],
    //         new Dictionary<(int,char),int>
    //         {
    //             {(0,'0'),0},
    //             {(1,'0'),1},
    //             {(0,'1'),1},
    //             {(1,'1'),0}
    //         },
    //         0,
    //         [0]
    //     );

        


}