#ifndef SHADERTRANSITIONVIEW_H
#define SHADERTRANSITIONVIEW_H

#include <QQuickItem>
#include <QStack>
#include <QDebug>
#include <QQmlComponent>

class ShaderTransitionView : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(ShaderTransitionView)

    Q_PROPERTY(ShaderEffect transition READ transition WRITE setTransition NOTIFY transitionChanged)

    Q_ENUMS(ShaderEffect)

public:
    ShaderTransitionView(QQuickItem *parent = 0);
    ~ShaderTransitionView();

    enum ShaderEffect {
        EffectWIND,
        ST_Wind,
        EffectPINWHEEL,
        ST_PinWheel,
        EffectCIRCLEOPEN,
        ST_CircleOpen,
        EffectDIRECTIONALWIPE,
        ST_DirectionalWipe,
        EffectRADIALWIPE,
        ST_RadialWipe,
        EffectPIXELIZE,
        ST_Pixelize,
        EffectFLIP,
        ST_Flip,
        EffectFOLD,
        ST_Fold,
        EffectDOORWAY,
        ST_Doorway,
        EffectFADECOLOR,
        ST_FadeColor,
        EffectMORPH,
        ST_Morph,
        EffectPOLKADOTS,
        ST_PolkaDots,
        EffectSQUEEZE,
        ST_Squeeze,
        EffectHORIZONTALSLIDE,
        ST_HorizontalSlide,
        EffectVERTICALSLIDE,
        ST_VerticalSlide,
        EffectCROSSZOOM,
        ST_CrossZoom,
        EffectSWIRL,
        ST_Swirl

    };
    ShaderEffect transition() const { return m_transition; }

    Q_INVOKABLE void pushQQuickItem( QQmlComponent* item ) { m_insideStack.push(item); }
    Q_INVOKABLE QQmlComponent* popQQuickItem() {
        if( m_insideStack.length() > 0 ) {
            return m_insideStack.pop();
        } else {
            return NULL;
        }
    }
    Q_INVOKABLE int lengthQQuickStack() { return m_insideStack.length(); }
    Q_INVOKABLE QQmlComponent* topQQuickItem() {
        if( m_insideStack.length() > 0 ) {
            return m_insideStack.top();
        } else {
            return NULL;
        }
    }
    Q_INVOKABLE void clearQQuickStack() { m_insideStack.clear(); }
    Q_INVOKABLE QQmlComponent* getQQuickItem( int index ) {
        if( (index > 0) && (index < m_insideStack.length() ) ) {
            return m_insideStack.takeAt( index );
        } else {
            return NULL;
        }
    }

public slots:
    void setTransition(ShaderEffect transition)
    {
        if (m_transition == transition)
            return;

        m_transition = transition;
        emit transitionChanged(transition);
    }

signals:
    void transitionChanged(ShaderEffect transition);

private:
    ShaderEffect m_transition;

    QStack<QQmlComponent*> m_insideStack;
};

#endif // SHADERTRANSITIONVIEW_H

