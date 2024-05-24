using System;
using System.Collections.Generic;

// TODO:
//  - Validate Methods
//  - Maybe fix the fact that StartState is modifiable

public class FiniteAutomaton<T>
{
    public HashSet<T> States { get; }
    public HashSet<char> Alphabet { get; }
    public Dictionary<(T, char), T> TransitionFunction { get; }
    public T StartState { get; }
    public HashSet<T> AcceptStates { get; }

    public FiniteAutomaton(HashSet<T> states, HashSet<char> alphabet, Dictionary<(T, char), T> transitionFunction,
                            T startState, HashSet<T> acceptStates)
    {
        States = new HashSet<T>(states,states.Comparer);
        Alphabet = new HashSet<char>(alphabet,alphabet.Comparer);
        TransitionFunction = new Dictionary<(T, char), T>(transitionFunction,transitionFunction.Comparer);
        StartState = startState;
        AcceptStates = new HashSet<T>(acceptStates,acceptStates.Comparer);

        ValidateAlphabet();
        ValidateStartState();
        ValidateAcceptStates();
        ValidateTransitionFunction();
    }

    // Nondeterministic Finite Automaton
    public static FiniteAutomaton<HashSet<T>> NonDeterministicFiniteAutomaton
    (HashSet<T> states, HashSet<char> alphabet, Dictionary<(T, char), HashSet<T>> transitionFunction,
                            T startState, HashSet<T> acceptStates)
    {
        var States = PowerSet(states);

        var Alphabet = new HashSet<char>(alphabet);
        Alphabet.Remove('\0');

        var TransitionFunction = ConvertToDeterministicFunction(transitionFunction,States,Alphabet);

        var StartState = EmptyStringClosure([startState],transitionFunction);

        var AcceptStates = ConvertToDeterministicAcceptStates(States,acceptStates);


        return new FiniteAutomaton<HashSet<T>>(States,Alphabet,TransitionFunction,StartState,AcceptStates);
    }

    public static HashSet<HashSet<T>> ConvertToDeterministicAcceptStates(HashSet<HashSet<T>> states, HashSet<T> acceptStates)
    {
        var returnVal = new HashSet<HashSet<T>>(new HashSetEqualityComparer<T>());
        foreach (var state in states)
        {
            if (state.Intersect(acceptStates).Any())
            {
                returnVal.Add(new HashSet<T>(state));
            }
        }

        return returnVal;
    }

    public static Dictionary<(HashSet<T>,char), HashSet<T>> ConvertToDeterministicFunction
    (Dictionary<(T, char), HashSet<T>> transitionFunction, HashSet<HashSet<T>> states, HashSet<char> alphabet)
    {
        var returnVal = new Dictionary<(HashSet<T>,char), HashSet<T>>(new HashSetCharEqualityComparer<T>());
        foreach (var state_set in states)
        {
            foreach (var chr in alphabet)
            {
                var currentTransitionValue = new HashSet<T>();
                foreach (var state in state_set)
                {
                    if (transitionFunction.ContainsKey((state, chr)))
                    {
                        var emptyStringClosure = EmptyStringClosure(transitionFunction[(state,chr)],transitionFunction);
                        currentTransitionValue.UnionWith(emptyStringClosure);
                    }
                }
                returnVal.Add((state_set,chr),currentTransitionValue);
            }
        }

        return returnVal;
    }

    public static HashSet<T> EmptyStringClosure(HashSet<T> states, Dictionary<(T, char), HashSet<T>> transitionFunction)
    {   
        HashSet<T> returnVal = new HashSet<T>();

        EmptyStringClosureHelper(states,transitionFunction,returnVal);

        return returnVal;
    }

    public static void EmptyStringClosureHelper(HashSet<T> states, Dictionary<(T, char), HashSet<T>> transitionFunction, HashSet<T> visited)
    {
        while (states.Except(visited).Any())
        {
            T currState = states.Except(visited).First();
            visited.Add(currState);
            if (transitionFunction.ContainsKey((currState,'\0')))
            {
                EmptyStringClosureHelper(transitionFunction[(currState,'\0')],transitionFunction,visited);
            }
        }
    }


    public static HashSet<HashSet<T>> PowerSet(HashSet<T> states)
    {   
        var returnVal = new HashSet<HashSet<T>>(new HashSetEqualityComparer<T>());
        for (int i = 0; i <= states.Count; i++)
        {
            returnVal.UnionWith(ChooseK(states,i));
        }

        return returnVal;
    }

    public static HashSet<HashSet<T>> ChooseK(HashSet<T> states, int k)
    {
        HashSet<HashSet<T>> result = new HashSet<HashSet<T>>();
        if (k == 0)
        {
            result.Add(new HashSet<T>());
            return result;
        }
        if (states.Count == 0)
        {
            return result;
        }

        T firstElement = states.FirstOrDefault() ?? throw new ArgumentNullException("HashSet Elements must not be null");

        HashSet<T> remainingElements = new HashSet<T>(states);
        remainingElements.Remove(firstElement);

        foreach (HashSet<T> subset in ChooseK(remainingElements, k - 1))
        {
            subset.Add(firstElement);
            result.Add(subset);
        }

        result.UnionWith(ChooseK(remainingElements, k));

        return result;
    }

    private void ValidateAlphabet()
    {
        if (Alphabet.Contains('\0'))
        {
            throw new ArgumentException($"Alphabet may not contain the empty string '\\0'");
        }
    }

    private void ValidateStartState()
    {
        if (!States.Contains(StartState))
        {
            throw new InvalidOperationException($"Start state {StartState} is not in defined states.");
        }
    }

    private void ValidateAcceptStates()
    {
        foreach (var curState in AcceptStates)
        {
            if (!States.Contains(curState))
            {
                throw new InvalidOperationException($"Accept state {curState} is not in defined states.");
            }
        }
    }

    private void ValidateTransitionFunction()
    {
        foreach (var state in States)
        {
            foreach (var symbol in Alphabet)
            {
                if (!TransitionFunction.ContainsKey((state, symbol)))
                {
                    throw new InvalidOperationException($"Transition function is not defined for state {state} and symbol '{symbol}'.");
                }
            }
        }
    }

    public bool Accepts(string input)
    {
        T currentState = StartState;

        foreach (char symbol in input)
        {
            if (!Alphabet.Contains(symbol))
            {
                throw new ArgumentException($"Symbol '{symbol}' is not in the language alphabet.");
            }

            currentState = TransitionFunction[(currentState, symbol)];
        }

        return AcceptStates.Contains(currentState);
    }


    public static FiniteAutomaton<(T1,T2)> Union<T1,T2>(FiniteAutomaton<T1> m1, FiniteAutomaton<T2> m2)
    {
        var states = new HashSet<(T1, T2)>();

        foreach (var stateM1 in m1.States)
        {
            foreach (var stateM2 in m2.States)
            {
                states.Add((stateM1,stateM2));
            }
        }


        if (!m1.Alphabet.SetEquals(m2.Alphabet))
        {
            throw new InvalidOperationException($"Alphabets do not match.");
        }

        var alphabet = new HashSet<char>(m1.Alphabet);


        var transitionFunction = new Dictionary<((T1,T2),char),(T1,T2)>();
        foreach (var stateM1 in m1.States)
        {
            foreach (var stateM2 in m2.States)
            {
                foreach (var chr in alphabet)
                {
                    transitionFunction.Add(((stateM1,stateM2),chr),(m1.TransitionFunction[(stateM1,chr)],m2.TransitionFunction[(stateM2,chr)]));
                }
            }
        }

        var startState = (m1.StartState,m2.StartState);

        var acceptStates = new HashSet<(T1,T2)>();
        foreach (var accStateM1 in m1.AcceptStates)
        {
            foreach (var stateM2 in m2.States)
            {
                acceptStates.Add((accStateM1,stateM2));
            }
        } 
        foreach (var stateM1 in m1.States)
        {
            foreach (var accStateM2 in m2.AcceptStates)
            {
                acceptStates.Add((stateM1,accStateM2));
            }
        } 

        return new FiniteAutomaton<(T1,T2)>(states,alphabet,transitionFunction,startState,acceptStates);
    }
}


public class HashSetEqualityComparer<T> : IEqualityComparer<HashSet<T>>
{
    public bool Equals(HashSet<T>? x, HashSet<T>? y)
    {
        if (x == null || y == null)
            return x == y;

        return x.SetEquals(y);
    }

    public int GetHashCode(HashSet<T> obj)
    {
        if (obj == null)
            return 0;

        int hash = 0;
        foreach (var item in obj)
        {
            hash ^= item?.GetHashCode() ?? 17;
        }
        return hash;
    }
}

public class HashSetCharEqualityComparer<T> : IEqualityComparer<(HashSet<T>, char)>
{
    public bool Equals((HashSet<T>, char) x, (HashSet<T>, char) y)
    {
        var (setX, charX) = x;
        var (setY, charY) = y;

        if (setX == null || setY == null)
            return setX == setY && charX == charY;

        return setX.SetEquals(setY) && charX == charY;
    }

    public int GetHashCode((HashSet<T>, char) obj)
    {
        var (set, character) = obj;

        if (set == null)
            return character.GetHashCode();

        int hash = character.GetHashCode();
        foreach (var item in set)
        {
            hash ^= item?.GetHashCode() ?? 17;
        }
        return hash;
    }
}