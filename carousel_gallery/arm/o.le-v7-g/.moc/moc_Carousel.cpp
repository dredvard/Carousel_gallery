/****************************************************************************
** Meta object code from reading C++ file 'Carousel.hpp'
**
** Created: Fri Oct 5 18:51:21 2012
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/Carousel.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Carousel.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Carousel[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      25,   21,   10,    9, 0x02,
      56,    9,   43,    9, 0x02,
      92,   75,   66,    9, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_Carousel[] = {
    "Carousel\0\0QByteArray\0str\0getBytes(QString)\0"
    "QEasingCurve\0getEase()\0QVariant\0"
    "inputFName,pitch\0createMirrorImage(QString,int)\0"
};

void Carousel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        Carousel *_t = static_cast<Carousel *>(_o);
        switch (_id) {
        case 0: { QByteArray _r = _t->getBytes((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QByteArray*>(_a[0]) = _r; }  break;
        case 1: { QEasingCurve _r = _t->getEase();
            if (_a[0]) *reinterpret_cast< QEasingCurve*>(_a[0]) = _r; }  break;
        case 2: { QVariant _r = _t->createMirrorImage((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData Carousel::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject Carousel::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Carousel,
      qt_meta_data_Carousel, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Carousel::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Carousel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Carousel::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Carousel))
        return static_cast<void*>(const_cast< Carousel*>(this));
    return QObject::qt_metacast(_clname);
}

int Carousel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
