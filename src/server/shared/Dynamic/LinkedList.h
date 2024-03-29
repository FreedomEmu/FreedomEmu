/*
 * Copyright (C) 2008 - 2011 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2010 - 2012 Myth Project <http://mythprojectnetwork.blogspot.com/>
 *
 * Myth Project's source is based on the Trinity Project source, you can find the
 * link to that easily in Trinity Copyrights. Myth Project is a private community.
 * To get access, you either have to donate or pass a developer test.
 * You can't share Myth Project's sources! Only for personal use.
 */

#ifndef _LINKEDLIST
#define _LINKEDLIST

#include "Common.h"

class LinkedListHead;

class LinkedListElement
{
private:
    friend class LinkedListHead;

    LinkedListElement* iNext;
    LinkedListElement* iPrev;
public:
    LinkedListElement() { iNext = NULL; iPrev = NULL; }
    ~LinkedListElement() { delink(); }

    bool hasNext()  const   { return(iNext && iNext != NULL && iNext->iNext != NULL); }
    bool hasPrev()  const   { return(iPrev && iPrev != NULL && iPrev->iPrev != NULL); }
    bool isInList() const   { return(iNext != NULL && iPrev != NULL); }

    LinkedListElement      * next()       { return hasNext() ? iNext : NULL; }
    LinkedListElement const* next() const { return hasNext() ? iNext : NULL; }
    LinkedListElement      * prev()       { return hasPrev() ? iPrev : NULL; }
    LinkedListElement const* prev() const { return hasPrev() ? iPrev : NULL; }

    LinkedListElement      * nocheck_next()       { return iNext; }
    LinkedListElement const* nocheck_next() const { return iNext; }
    LinkedListElement      * nocheck_prev()       { return iPrev; }
    LinkedListElement const* nocheck_prev() const { return iPrev; }

    void delink()
    {
        if(isInList())
        {
            iNext->iPrev = iPrev; iPrev->iNext = iNext; iNext = NULL; iPrev = NULL;
        }
    }

    void insertBefore(LinkedListElement* pElem)
    {
        pElem->iNext = this;
        pElem->iPrev = iPrev;
        iPrev->iNext = pElem;
        iPrev = pElem;
    }

    void insertAfter(LinkedListElement* pElem)
    {
        pElem->iPrev = this;
        pElem->iNext = iNext;
        iNext->iPrev = pElem;
        iNext = pElem;
    }
};

class LinkedListHead
{
private:
    LinkedListElement iFirst;
    LinkedListElement iLast;
    uint32 iSize;
public:
    LinkedListHead()
    {
        iFirst.iNext = &iLast;
        iLast.iPrev = &iFirst;
        iSize = 0;
    }

    bool isEmpty() const { return(!iFirst.iNext->isInList()); }

    LinkedListElement      * getFirst()       { return(isEmpty() ? NULL : iFirst.iNext); }
    LinkedListElement const* getFirst() const { return(isEmpty() ? NULL : iFirst.iNext); }

    LinkedListElement      * getLast() { return(isEmpty() ? NULL : iLast.iPrev); }
    LinkedListElement const* getLast() const  { return(isEmpty() ? NULL : iLast.iPrev); }

    void insertFirst(LinkedListElement* pElem)
    {
        iFirst.insertAfter(pElem);
    }

    void insertLast(LinkedListElement* pElem)
    {
        iLast.insertBefore(pElem);
    }

    uint32 getSize() const
    {
        if(!iSize)
        {
            uint32 result = 0;
            LinkedListElement const* e = getFirst();
            while(e)
            {
                ++result;
                e = e->next();
            }
            return result;
        }
        else
            return iSize;
    }

    void incSize() { ++iSize; }
    void decSize() { --iSize; }

    template<class _Ty>
        class Iterator
    {
        public:
            typedef std::bidirectional_iterator_tag     iterator_category;
            typedef _Ty                                 value_type;
            typedef ptrdiff_t                           difference_type;
            typedef ptrdiff_t                           distance_type;
            typedef _Ty*                                pointer;
            typedef _Ty const*                          const_pointer;
            typedef _Ty&                                reference;
            typedef _Ty const &                         const_reference;

            Iterator() : _Ptr(0)
            {                                           // construct with null node pointer
            }

            Iterator(pointer _Pnode) : _Ptr(_Pnode)
            {                                           // construct with node pointer _Pnode
            }

            Iterator& operator=(Iterator const &_Right)
            {
                return (*this) = _Right._Ptr;
            }
              Iterator& operator=(const_pointer const &_Right)
            {
                _Ptr = (pointer)_Right;
                return (*this);
            }

            reference operator*()
            {                                           // return designated value
                return *_Ptr;
            }

            pointer operator->()
            {                                           // return pointer to class object
                return _Ptr;
            }

            Iterator& operator++()
            {                                           // preincrement
                _Ptr = _Ptr->next();
                return (*this);
            }

            Iterator operator++(int)
            {                                           // postincrement
                iterator _Tmp = *this;
                ++*this;
                return (_Tmp);
            }

            Iterator& operator--()
            {                                           // predecrement
                _Ptr = _Ptr->prev();
                return (*this);
            }

            Iterator operator--(int)
            {                                           // postdecrement
                iterator _Tmp = *this;
                --*this;
                return (_Tmp);
            }

            bool operator==(Iterator const &_Right) const
            {                                           // test for iterator equality
                return (_Ptr == _Right._Ptr);
            }

            bool operator!=(Iterator const &_Right) const
            {                                           // test for iterator inequality
                return (!(*this == _Right));
            }

            bool operator==(pointer const &_Right) const
            {                                           // test for pointer equality
                return (_Ptr != _Right);
            }

            bool operator!=(pointer const &_Right) const
            {                                           // test for pointer equality
                return (!(*this == _Right));
            }

            bool operator==(const_reference _Right) const
            {                                           // test for reference equality
                return (_Ptr == &_Right);
            }

            bool operator!=(const_reference _Right) const
            {                                           // test for reference equality
                return (_Ptr != &_Right);
            }

            pointer _Mynode()
            {                                           // return node pointer
                return (_Ptr);
            }

        protected:
            pointer _Ptr;                               // pointer to node
    };

    typedef Iterator<LinkedListElement> iterator;
};
#endif