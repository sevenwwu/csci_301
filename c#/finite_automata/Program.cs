

using System.Collections.Immutable;

public class Program
{

    public static void Main()
    {
        var machine = FiniteAutomaton<int>.NonDeterministicFiniteAutomaton(
            [1,2,3,4,5],
            ['a','b','\0'],
            new Dictionary<(int, char), HashSet<int>>
            {
                {(1,'\0'),[2]},
                {(2,'\0'),[1,3]},
                {(1,'a'),[3]},
                {(2,'a'),[4,5]},
                {(3,'b'),[4]},
                {(4,'a'),[5]},
                {(4,'b'),[5]}
            },
            1,
            [5]
        );

        machine.States.PrintAll<int>();
        Console.WriteLine();
        machine.Alphabet.Print<char>();
        Console.WriteLine();
        machine.TransitionFunction.Print();
        Console.WriteLine();
        machine.StartState.Print();
        Console.WriteLine();
        Console.WriteLine();
        machine.AcceptStates.PrintAll();

        // Console.WriteLine(machine.Accepts(""));
        // Console.WriteLine(machine.Accepts("a"));
        // Console.WriteLine(machine.Accepts("aa"));
        // Console.WriteLine(machine.Accepts("aaa"));
        // Console.WriteLine(machine.Accepts("aba"));


        // HashSet<HashSet<int>> sets = [];

        // sets.Add([1,2,3]);
        // sets.Add([1,2,3]);

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

public static class PrintShit
{
    public static void PrintAll<T>(this ImmutableHashSet<HashSet<T>> hashSetOfHashSets)
    {
        foreach (var innerHashSet in hashSetOfHashSets)
        {
            innerHashSet.Print();
            Console.WriteLine();
        }
    }

    public static void Print<T>(this HashSet<T> hashSet)
    {
        Console.Write("[");
        foreach (var item in hashSet)
        {
            Console.Write(item + ", ");
        }
        Console.Write("]");
    }

    public static void Print<T>(this ImmutableHashSet<T> hashSet)
    {
        Console.Write("[");
        foreach (var item in hashSet)
        {
            Console.Write(item + ", ");
        }
        Console.Write("]");
    }

    public static void Print(this ImmutableDictionary<(HashSet<int>, char), HashSet<int>> dictionary)
    {
        foreach (var kvp in dictionary)
        {
            var (hashSet, character) = kvp.Key;
            var valueHashSet = kvp.Value;

            Console.Write("(");
            hashSet.Print();
            Console.Write($", {character}) --> ");
            valueHashSet.Print();
            Console.WriteLine();
        }
    }
}