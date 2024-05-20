

public class Program
{

    // echo $(head /dev/urandom | tr -dc '01' | head -c $((RANDOM % 16 + 5)))
    public static void Main()
    {
        // three ones in a row
        // states: 0 1 2 3
        // alphabet: '0' '1'
        // transition table:
        //      | 0  1  2  3
        // ------------------
        //  '0' | 0  0  0  3
        //  '1' | 1  2  3  3
        // start state: 0
        // accept states: 3

        var threeOnesInARow = new FiniteAutomaton<int>
        (
            [0,1,2,3],
            ['0','1'],
            new Dictionary<(int, char), int>{
                {(0,'0'),0},
                {(0,'1'),1},
                {(1,'0'),0},
                {(1,'1'),2},
                {(2,'0'),0},
                {(2,'1'),3},
                {(3,'0'),3},
                {(3,'1'),3}
            },
            0,
            [3]
        );

        // even number of 1s
        // states: 0 1
        // alphabet: '0' '1'
        // transition table:
        //      | 0  1
        // ---------------
        //  '0' | 0  1
        //  '1' | 1  0 
        // start state: 0
        // accept states: 0

        var evenNumOnes = new FiniteAutomaton<int>
        (
            [0,1],
            ['0','1'],
            new Dictionary<(int,char),int>
            {
                {(0,'0'),0},
                {(1,'0'),1},
                {(0,'1'),1},
                {(1,'1'),0}
            },
            0,
            [0]
        );

        

        List<string> strings = [
            "",
            "1111110100100",
            "000000001010000111",
            "001010",
            "001000010",
            "0001010",
            "110111111100",
            "11000011101111111",
            "10101"
        ];

        foreach (var str in strings)
        {
            Console.WriteLine($"{str}: {threeOnesInARow.Accepts(str)}");
        }

        Console.WriteLine("------------------------------");

        foreach (var str in strings)
        {
            Console.WriteLine($"{str}: {evenNumOnes.Accepts(str)}");
        }

        Console.WriteLine("------------------------------");

        var union = FiniteAutomaton<(int,int)>.Union<int,int>(threeOnesInARow,evenNumOnes);
        foreach(var str in strings)
        {
            Console.WriteLine($"{str}: {union.Accepts(str)}");
        }
    }



}