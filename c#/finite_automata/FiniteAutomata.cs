using System;
using System.Collections.Generic;



public class FiniteAutomaton<T>
{
    private HashSet<T> _states;
    private HashSet<char> _alphabet;
    private Dictionary<(T, char), T> _transitionFunction;
    private T _startState;
    private HashSet<T> _acceptStates;

    public FiniteAutomaton(HashSet<T> states, HashSet<char> alphabet, Dictionary<(T, char), T> transitionFunction,
                            T startState, HashSet<T> acceptStates)
    {
        _states = states;
        _alphabet = alphabet;
        _transitionFunction = transitionFunction;
        _startState = startState;
        _acceptStates = acceptStates;

        ValidateStartState();
        ValidateAcceptStates();
        ValidateTransitionFunction();
    }

    private void ValidateStartState()
    {
        if (!_states.Contains(_startState))
        {
            throw new InvalidOperationException($"Start state {_startState} is not in defined states.");
        }
    }

    private void ValidateAcceptStates()
    {
        foreach (var curState in _acceptStates)
        {
            if (!_states.Contains(curState))
            {
                throw new InvalidOperationException($"Accept state {curState} is not in defined states.");
            }
        }
    }

    private void ValidateTransitionFunction()
    {
        foreach (var state in _states)
        {
            foreach (var symbol in _alphabet)
            {
                if (!_transitionFunction.ContainsKey((state, symbol)))
                {
                    throw new InvalidOperationException($"Transition function is not defined for state {state} and symbol '{symbol}'.");
                }
            }
        }
    }

    public bool Accepts(string input)
    {
        T currentState = _startState;

        foreach (char symbol in input)
        {
            if (!_alphabet.Contains(symbol))
            {
                throw new ArgumentException($"Symbol '{symbol}' is not in the language alphabet.");
            }

            currentState = _transitionFunction[(currentState, symbol)];
        }

        return _acceptStates.Contains(currentState);
    }


    public static FiniteAutomaton<(T1,T2)> Union<T1,T2>(FiniteAutomaton<T1> m1, FiniteAutomaton<T2> m2)
    {
        var states = new HashSet<(T1, T2)>();

        foreach (var stateM1 in m1._states)
        {
            foreach (var stateM2 in m2._states)
            {
                states.Add((stateM1,stateM2));
            }
        }


        if (!m1._alphabet.SetEquals(m2._alphabet))
        {
            throw new InvalidOperationException($"Alphabets do not match.");
        }

        var alphabet = new HashSet<char>(m1._alphabet);


        var transitionFunction = new Dictionary<((T1,T2),char),(T1,T2)>();
        foreach (var stateM1 in m1._states)
        {
            foreach (var stateM2 in m2._states)
            {
                foreach (var chr in alphabet)
                {
                    transitionFunction.Add(((stateM1,stateM2),chr),(m1._transitionFunction[(stateM1,chr)],m2._transitionFunction[(stateM2,chr)]));
                }
            }
        }

        var startState = (m1._startState,m2._startState);

        var acceptStates = new HashSet<(T1,T2)>();
        foreach (var accStateM1 in m1._acceptStates)
        {
            foreach (var stateM2 in m2._states)
            {
                acceptStates.Add((accStateM1,stateM2));
            }
        } 
        foreach (var stateM1 in m1._states)
        {
            foreach (var accStateM2 in m2._acceptStates)
            {
                acceptStates.Add((stateM1,accStateM2));
            }
        } 

        return new FiniteAutomaton<(T1,T2)>(states,alphabet,transitionFunction,startState,acceptStates);
    }
}